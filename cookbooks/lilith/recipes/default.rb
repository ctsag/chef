cookbook_file '/etc/selinux/config' do
	source 'selinux_config'
end

execute 'selinux_disable' do
	command 'setenforce 0'
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
