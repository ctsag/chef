# Install essential packages
package 'epel-release'
package 'git'
package 'vim'
package 'wget'
package 'yum-utils'
package 'bash-completion'
package 'tree'
package 'net-tools'
package 'nmap'
package 'bind-utils'
package 'telnet'
package 'strace'
package 'colordiff'

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

# Open up ssh, http and https ports
cookbook_file '/etc/firewalld/zones/public.xml' do
	source 'firewalld_public.xml'
end

service 'firewalld' do
	action :restart
end

# Stop the postfix service
service 'postfix' do
	action [:stop, :disable]
end
