#TODO decide whether the following include_recipe is a good idea
# Include the default recipe
include_recipe 'nothingness::default'

# Install the httpd package
package node['pkg']['httpd']

# Put the httpd configuration in place
cookbook_file '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf'
end

# Create the httpd content directory structure
directories = [
  '/srv/www',
  '/srv/www/default',
]

directories.each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

# TODO replace with a custom resource or a firewall resource
# Open up the http port
execute 'firewall_http' do
  command 'firewall-cmd --add-port=80/tcp --permanent'
end

# TODO replace with a custom resource or a firewall resource
# Open up the https port
execute 'firewall_https' do
  command 'firewall-cmd --add-port=443/tcp --permanent'
end

# Start and enable the httpd service
service 'httpd' do
  action [:enable, :start]
end
