#TODO decide whether the following include_recipe is a good idea
# Include the docker recipe
include_recipe 'nothingness::docker'

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
template '/etc/httpd/conf.d/jenkins.conf' do
  source 'vhost_jenkins.conf.erb'
end

# Add the jenkins user to the docker group
group 'docker' do
  members 'jenkins'
  append true
  action :modify
end

# Restart the httpd service
service 'httpd' do
  action :restart
end
