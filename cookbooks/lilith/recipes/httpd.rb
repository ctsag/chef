package 'httpd'

template '/etc/httpd/conf/httpd.conf' do
	source 'httpd.conf.erb'
end

directory '/srv/www' do
	owner 'root'
	group 'root'
	mode '755'
	action :create
end

directory '/srv/www/default' do
	owner 'root'
	group 'root'
	mode '755'
	action :create
end

service 'httpd' do
	action [:enable, :start]
end

