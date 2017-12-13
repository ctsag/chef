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

cookbook_file '/srv/www/ls-blog/public/index.html' do
	source 'ls-blog_index.html'
	owner 'ctsag'
	group 'ctsag'
end

cookbook_file '/etc/httpd/conf.d/lilith.conf' do
	source 'lilith.conf'
end

service 'httpd' do
	action :restart
end
