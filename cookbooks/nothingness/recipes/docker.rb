#TODO decide whether the following include_recipe is a good idea
# Include the users recipe
include_recipe 'nothingness::users'

# Purge vanilla docker packages
service 'docker' do
  action [:disable, :stop]
end

node['pkg']['docker']['purged'].each do |package_name|
  package package_name do
    action :purge
  end
end

# Create the official docker repository
yum_repository 'docker' do
  description 'Docker yum repository'
  baseurl node['repo']['docker']['baseurl']
  gpgkey node['repo']['docker']['gpgkey']
  action :create
end

# Install Docker CE and suggested packages
node['pkg']['docker']['installed'].each do |package_name|
  package package_name
end

# Download and install docker-compose
remote_file '/usr/local/bin/docker-compose' do
  source 'https://github.com/docker/compose/releases/download/1.17.1/docker-compose-Linux-x86_64'
  owner 'root'
  group 'root'
  mode '0755'
end

# Download and install docker-machine
remote_file '/usr/local/bin/docker-machine' do
  source 'https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-Linux-x86_64'
  owner 'root'
  group 'root'
  mode '0755'
end

# Add the default user to the docker group
group 'docker' do
  members 'ctsag'
  append true
  action :create
end

# Start and enable the docker service
service 'docker' do
  action [:enable, :start]
end
