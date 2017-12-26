# Include the httpd recipe
include_recipe 'nothingness::httpd'

# Create the directory structure for the ls-blog site
directories = [
  '/srv/www/ls-blog',
  '/srv/www/ls-blog/logs',
  '/srv/www/ls-blog/public',
]

directories.each do |dir|
  directory dir do
    owner 'ctsag'
    group 'ctsag'
    mode '0755'
    action :create
  end
end

# Put the site's vhost configuration in place
template '/etc/httpd/conf.d/ls-blog.conf' do
  source 'vhost_ls-blog.conf.erb'
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
