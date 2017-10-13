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
write_files:
  - path: /tmp/user-data-shell
    content: |
      #!/bin/bash
      yum -y --enablerepo=epel install ansible pyOpenSSL docker-1.12.6
      systemctl enable docker
      sed -i '/OPTIONS=.*/c\OPTIONS="--selinux-enabled --insecure-registry 172.30.0.0/16"' /etc/sysconfig/docker
      systemctl start docker
      systemctl start NetworkManager && systemctl enable NetworkManager
      if [ ! -d "openshift-ansible" ]
        then su - -c "git clone https://github.com/openshift/openshift-ansible && ansible-playbook -i /tmp/inventory ./openshift-ansible/playbooks/byo/config.yml"
      fi
  - path: /tmp/inventory/ansiblehosts
    content: |
      # Create an OSEv3 group that contains the masters and nodes groups
      [OSEv3:children]
      masters
      nodes
      etcd

      # Set variables common for all OSEv3 hosts
      [OSEv3:vars]
      openshift_disable_check=memory_availability, disk_availability, docker_storage
      # SSH user, this user should allow ssh based auth without requiring a password
      ansible_user=root
      ansible_connection=local

      # If ansible_ssh_user is not root, ansible_become must be set to true
      ansible_become=false

      openshift_deployment_type=origin

      [eu-west-1]

      # host group for masters
      [masters:children]
      eu-west-1

      # host group for etcd
      [etcd:children]
      eu-west-1

      # host group for nodes, includes region info
      [nodes:children]
      eu-west-1

      [nodes:vars]
      openshift_schedulable=true 
runcmd:
  - wget -o /tmp/inventory/ec2.py https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py 
  - chmod +x /tmp/inventory/ec2.py
  - bash /tmp/user-data-shell