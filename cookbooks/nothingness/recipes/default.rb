package 'git'
package 'vim'
package 'wget'
package 'yum-utils'
package 'bash-completion'
package 'tree'
package 'net-tools'
package 'nmap'
package 'bind-utils'

cookbook_file '/etc/selinux/config' do
	source 'selinux_config'
end

execute 'selinux_disable' do
	command 'setenforce 0'
	returns [0,1]
end

cookbook_file '/etc/firewalld/zones/public.xml' do
	source 'firewalld_public.xml'
end

service 'firewalld' do
	action :restart
end

service 'postfix' do
	action [:stop, :disable]
end
