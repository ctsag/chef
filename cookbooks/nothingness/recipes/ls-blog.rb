# Create the base directory for the ls-blog site
directory '/srv/www/ls-blog' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

# Create the log directory for the ls-blog site
directory '/srv/www/ls-blog/logs' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

# Create the content directory for the ls-blog site
directory '/srv/www/ls-blog/public' do
	owner 'ctsag'
	group 'ctsag'
	mode '0755'
	action :create
end

# Put the site's vhost configuration in place
cookbook_file '/etc/httpd/conf.d/nothingness.conf' do
	source 'nothingness.conf'
end

# Restart the httpd service
service 'httpd' do
	action :restart
end

# Put a demo page in place
cookbook_file '/srv/www/ls-blog/public/index.html' do
	source 'ls-blog_index.html'
	owner 'ctsag'
	group 'ctsag'
end
