template '/etc/selinux/config' do
	source 'selinux_config.erb'
end

execute 'selinux_disable' do
	command 'setenforce 0'
end

template '/etc/firewalld/zones/public.xml' do
	source 'firewalld_public.xml.erb'
end

service 'firewalld' do
	action :restart
end
