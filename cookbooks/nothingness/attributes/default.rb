default['packages']['essential'] = [
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
]

default['packages']['docker']['installed'] = [
  'device-mapper-persistent-data',
  'lvm2',
  'docker-ce',
]

default['packages']['docker']['purged'] = [
  'docker',
  'docker-common',
  'docker-selinux',
  'docker-engine',
]

default['packages']['httpd'] = [
  'httpd',
]

default['packages']['vagrant']['name'] = 'vagrant'
default['packages']['vagrant']['source'] = 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm'

default['packages']['virtualbox'] = [
  'kernel-devel',
  'gcc',
  'VirtualBox-5.2',
]
