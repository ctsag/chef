default['repo']['virtualbox']['baseurl'] = 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch'
default['repo']['virtualbox']['gpgkey'] = 'https://www.virtualbox.org/download/oracle_vbox.asc'

default['repo']['docker']['baseurl'] = 'https://download.docker.com/linux/centos/7/$basearch/stable'
default['repo']['docker']['gpgkey'] = 'https://download.docker.com/linux/centos/gpg'

default['repo']['jenkins']['baseurl'] = 'http://pkg.jenkins.io/redhat-stable'
default['repo']['jenkins']['gpgkey'] = 'https://pkg.jenkins.io/redhat-stable/jenkins.io.key'
