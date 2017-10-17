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
  - git
  - NetworkManager
write_files:
  - path: /tmp/inventory/ec2.ini
    content: |
      [ec2]

      regions = all
      regions_exclude = us-gov-west-1, cn-north-1

      destination_variable = private_dns_name
      vpc_destination_variable = private_ip_address
      hostname_variable = private_dns_name

      route53 = False
      all_instances = False
      all_rds_instances = False

      # Include RDS cluster information (Aurora etc.)
      include_rds_clusters = False

      all_elasticache_replication_groups = False
      all_elasticache_clusters = False
      all_elasticache_nodes = False

      cache_path = ~/.ansible/tmp

      cache_max_age = 300

      # Organize groups into a nested/hierarchy instead of a flat namespace.
      nested_groups = False

      # Replace - tags when creating groups to avoid issues with ansible
      replace_dash_in_groups = True

      # If set to true, any tag of the form "a,b,c" is expanded into a list
      # and the results are used to create additional tag_* inventory groups.
      expand_csv_tags = False

      # The EC2 inventory output can become very large. To manage its size,
      # configure which groups should be created.
      group_by_instance_id = True
      group_by_region = True
      group_by_availability_zone = True
      group_by_aws_account = False
      group_by_ami_id = True
      group_by_instance_type = True
      group_by_instance_state = False
      group_by_platform = True
      group_by_key_pair = True
      group_by_vpc_id = True
      group_by_security_group = True
      group_by_tag_keys = True
      group_by_tag_none = True
      group_by_route53_names = True
      group_by_rds_engine = True
      group_by_rds_parameter_group = True
      group_by_elasticache_engine = True
      group_by_elasticache_cluster = True
      group_by_elasticache_parameter_group = True
      group_by_elasticache_replication_group = True

      stack_filters = False
      [credentials]
  - path: /tmp/user-data-shell
    content: |
      #!/bin/bash
      sudo su -
      yum -y --enablerepo=epel install ansible pyOpenSSL docker-1.12.6
      sed -i '/OPTIONS=.*/c\OPTIONS="--selinux-enabled --insecure-registry 172.30.0.0/16"' /etc/sysconfig/docker
      systemctl start docker
      systemctl enable docker
      systemctl start NetworkManager && systemctl enable NetworkManager
      if [ ! -d "openshift-ansible" ]
        then git clone https://github.com/openshift/openshift-ansible && EC2_INI_PATH=/tmp/inventory/ec2.ini ansible-playbook -i /tmp/inventory ./openshift-ansible/playbooks/byo/config.yml
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
      openshift_clock_enabled=true

      # If ansible_ssh_user is not root, ansible_become must be set to true
      ansible_become=false

      openshift_deployment_type=origin

      [tag_aws_autoscaling_groupName_${master_asg_name}]

      # host group for masters
      [masters:children]
      tag_aws_autoscaling_groupName_${master_asg_name}

      [masters:vars]
      openshift_schedulable=true

      # host group for etcd
      [etcd:children]
      tag_aws_autoscaling_groupName_${master_asg_name}

      # host group for nodes, includes region info
      [nodes:children]
      tag_aws_autoscaling_groupName_${master_asg_name}

bootcmd:
  - mkdir /tmp/inventory
runcmd:
  - wget -O /tmp/inventory/ec2.py https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py 
  - chmod +x /tmp/inventory/ec2.py
  - bash -l /tmp/user-data-shell