# Include the default recipe
include_recipe 'nothingness::default'

# Install the httpd package
node['packages']['httpd'].each do |package_name|
  package package_name
end

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

# Open up http port
execute 'firewall_http' do
  command 'firewall-cmd --add-port=80/tcp --permanent'
end

# Open up https port
execute 'firewall_https' do
  command 'firewall-cmd --add-port=443/tcp --permanent'
end

# Start and enable the httpd service
service 'httpd' do
  action [:enable, :start]
end
