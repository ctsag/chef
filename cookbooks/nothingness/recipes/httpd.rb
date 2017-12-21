include_recipe 'nothingness::default'

# Install the  httpd package
package 'httpd'

# Put the httpd configuration in place
cookbook_file '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf'
end

# Create the httpd content directory
directory '/srv/www' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Create the content directory for the default site
directory '/srv/www/default' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
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
