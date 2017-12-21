include_recipe 'nothingness::users'
include_recipe 'nothingness::virtualbox'

# Remove vanilla docker packages
service 'docker' do
  action [:disable, :stop]
end

package 'docker' do
  action :purge
end

package 'docker-common' do
  action :purge
end

package 'docker-selinux' do
  action :purge
end

package 'docker-engine' do
  action :purge
end

# Add the official docker repository
yum_repository 'docker' do
  description 'Docker yum repository'
  baseurl 'https://download.docker.com/linux/centos/7/$basearch/stable'
  gpgkey 'https://download.docker.com/linux/centos/gpg'
  action :create
end

# Install docker-ce and suggested packages
package 'device-mapper-persistent-data'
package 'lvm2'
package 'docker-ce'

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
