#cloud-config
yum_repos:
    epel:
        baseurl: http://download.fedoraproject.org/pub/epel/testing/7/$basearch
        enabled: false
        gpgcheck: false
        name: Extra Packages for Enterprise Linux 7
packages:
  - wget
  - net-tools 
  - bind-utils 
  - iptables-services 
  - bridge-utils 
  - bash-completion 
  - kexec-tools 
  - sos 
  - psacct 
  - docker-1.12.6
  - git
  - NetworkManager
  - chrony
write_files:
  - path: /tmp/user-data-shell
    content: |
      #!/bin/bash
      yum -y --enablerepo=epel install ansible pyOpenSSL
      sed -i '/OPTIONS=.*/c\OPTIONS="--selinux-enabled --insecure-registry 172.30.0.0/16"' /etc/sysconfig/docker
      systemctl enable docker
      systemctl start docker
      systemctl start NetworkManager && systemctl enable NetworkManager
      systemctl start chronyd && systemctl enable chronyd
      if [ ! -d "openshift-ansible" ]; then git clone https://github.com/openshift/openshift-ansible ; fi
      ansible-playbook -i /tmp/ansiblehosts ./openshift-ansible/playbooks/byo/config.yml
  - path: /tmp/ansiblehosts
    content: |
      # Create an OSEv3 group that contains the masters and nodes groups
      [OSEv3:children]
      masters
      nodes

      # Set variables common for all OSEv3 hosts
      [OSEv3:vars]
      openshift_disable_check=memory_availability, disk_availability, docker_storage
      # SSH user, this user should allow ssh based auth without requiring a password
      ansible_user=root
      ansible_connection=local
      openshift_master_cluster_hostname=localhost
      openshift_master_cluster_public_hostname=localhost

      # If ansible_ssh_user is not root, ansible_become must be set to true
      ansible_become=false

      openshift_deployment_type=origin

      # uncomment the following to enable htpasswd authentication; defaults to DenyAllPasswordIdentityProvider
      #openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]

      # host group for masters
      [masters]
      localhost

      # host group for etcd
      [etcd]
      localhost

      # host group for nodes, includes region info
      [nodes]
      localhost  openshift_schedulable=true 
runcmd:
  - bash /tmp/user-data-shell