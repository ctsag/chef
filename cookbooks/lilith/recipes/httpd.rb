package 'httpd'

directory '/var/www/html/lilith.gr/public_html' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

template '/etc/httpd/conf/httpd.conf' do
	source 'httpd.conf.erb'
end

template '/etc/httpd/conf.d/lilith.conf' do
	source 'lilith.conf.erb'
end

template '/var/www/html/lilith.gr/public_html/index.html' do
	source 'index.html.erb'
	owner 'ctsag'
	group 'ctsag'
end

service 'httpd' do
	action [:enable, :restart]
end

