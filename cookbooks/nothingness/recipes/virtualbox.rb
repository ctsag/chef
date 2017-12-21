# Add the official VirtualBox repository
yum_repository 'virtualbox' do
	description 'VirtualBox yum repository'
	baseurl 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch'
	gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
	action :create
end

# Install VirtualBox and suggested packages
packages = [
	'kernel-devel',
	'gcc',
	'VirtualBox-5.2'
]

packages.each do |package_name|
	package(package_name)
end

# Rebuild and load the VirtualBox kernel module
execute 'vbox_config' do
	command '/sbin/vboxconfig'
end
