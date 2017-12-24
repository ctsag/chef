# Create the official Jenkins repository
yum_repository 'jenkins' do
  description 'Jenkins yum repository'
  baseurl node['repo']['jenkins']['baseurl']
  gpgkey node['repo']['jenkins']['gpgkey']
  action :create
end

# Install the Jenkins package
package node['pkg']['jenkins']

# Start and enable the Jenkins service
service 'jenkins' do
  action [:enable, :start]
end

# Open up the Jenkins port
execute 'firewall_jenkins' do
  command 'firewall-cmd --add-port=8080/tcp --permanent'
end

# Put the site's vhost configuration in place
cookbook_file '/etc/httpd/conf.d/jenkins.conf' do
  source 'vhost_jenkins.conf'
end

# Restart the httpd service
service 'httpd' do
  action :restart
end
