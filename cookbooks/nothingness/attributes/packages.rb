default['pkg']['essential'] = [
  'epel-release',
  'git',
  'vim-enhanced',
  'wget',
  'yum-utils',
  'bash-completion',
  'tree',
  'net-tools',
  'nmap',
  'bind-utils',
  'telnet',
  'strace',
  'colordiff',
  'java-1.8.0-openjdk',
  'ant',
  'maven',
]

default['pkg']['docker']['installed'] = [
  'device-mapper-persistent-data',
  'lvm2',
  'docker-ce',
]

default['pkg']['docker']['purged'] = [
  'docker',
  'docker-common',
  'docker-selinux',
  'docker-engine',
]

default['pkg']['vagrant']['name'] = 'vagrant'
default['pkg']['vagrant']['source'] = 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm'

default['pkg']['virtualbox'] = [
  'kernel-devel',
  'gcc',
  'VirtualBox-5.2',
]

default['pkg']['httpd'] = 'httpd'
default['pkg']['jenkins'] = 'jenkins'
