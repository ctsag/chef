directory '/srv/www/ls-blog' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

directory '/srv/www/ls-blog/logs' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

directory '/srv/www/ls-blog/public' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

template '/srv/www/ls-blog/public/index.html' do
	source 'index.html.erb'
	owner 'ctsag'
	group 'ctsag'
end

template '/etc/httpd/conf.d/lilith.conf' do
	source 'lilith.conf.erb'
end

service 'httpd' do
	action :restart
end
