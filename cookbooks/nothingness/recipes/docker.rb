include_recipe 'nothingness::users'
include_recipe 'nothingness::virtualbox'

yum_repository 'docker' do
	description 'Docker yum repository'
	baseurl 'https://download.docker.com/linux/centos/7/$basearch/stable'
	gpgkey 'https://download.docker.com/linux/centos/gpg'
	action :create
end

package 'device-mapper-persistent-data'
package 'lvm2'
package 'docker'

group 'docker' do
    members 'ctsag'
    append true
    action :create
end
