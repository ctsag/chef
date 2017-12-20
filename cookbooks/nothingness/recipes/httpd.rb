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

directory '/srv/www/default' do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

# Start and enable the httpd service
service 'httpd' do
	action [:enable, :start]
end

