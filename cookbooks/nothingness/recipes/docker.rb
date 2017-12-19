include_recipe 'nothingness::users'
include_recipe 'nothingness::virtualbox'

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

yum_repository 'docker' do
	description 'Docker yum repository'
	baseurl 'https://download.docker.com/linux/centos/7/$basearch/stable'
	gpgkey 'https://download.docker.com/linux/centos/gpg'
	action :create
end

package 'device-mapper-persistent-data'
package 'lvm2'
package 'docker-ce'

remote_file '/usr/local/bin/docker-compose' do
    source 'https://github.com/docker/compose/releases/download/1.17.1/docker-compose-Linux-x86_64'
	owner 'root'
	group 'root'
	mode '0755'
end

remote_file '/usr/local/bin/docker-machine' do
    source 'https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-Linux-x86_64'
    owner 'root'
    group 'root'
    mode '0755'
end

group 'docker' do
    members 'ctsag'
    append true
    action :create
end

service 'docker' do
    action [:enable, :start]
end
