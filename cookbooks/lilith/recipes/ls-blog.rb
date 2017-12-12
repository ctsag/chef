site_path = '/srv/www/ls-blog'
site_owner = 'ctsag'
site_group = 'ctsag'
site_mode = '0755'

directory site_path do
	owner site_owner
	group site_group
	mode site_mode
	action :create
end

directory site_path + '/content' do
	owner site_owner
	group site_group
	mode site_mode
	action :create
end

directory site_path + '/logs' do
	owner site_owner
	group site_group
	mode site_mode
	action :create
end

template site_path + '/content/index.html' do
	source 'index.html.erb'
	owner site_owner
	group site_group
end

template '/etc/httpd/conf.d/lilith.conf' do
	source 'lilith.conf.erb'
end

service 'httpd' do
	action :restart
end

