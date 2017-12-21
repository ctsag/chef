# Install essential packages
packages = [
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
	'colordiff'
]

packages.each do |package_name|
	package package_name
end

# Disable SELinux
cookbook_file '/etc/selinux/config' do
	source 'selinux_config'
end

execute 'selinux_disable' do
	command 'setenforce 0'
	returns [0,1]
end

# Set timezone to Athens, Greece
execute 'timezone_Athens' do
	command 'timedatectl set-timezone "Europe/Athens"'
end

# Start and enable the firewalld service
service 'firewalld' do
	action [:enable, :start]
end

# Stop the postfix service
service 'postfix' do
	action [:stop, :disable]
end
