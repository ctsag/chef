yum_repository 'virtualbox' do
	description 'VirtualBox yum repository'
	baseurl 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch'
	gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
	action :create
end

package 'kernel-devel'
package 'gcc'
package 'VirtualBox-5.2'

execute 'vbox_config' do
	command '/sbin/vboxconfig'
end

remote_file '/tmp/vagrant_2.0.1_x86_64.rpm' do
	source 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm'
end

package 'vagrant' do
	source '/tmp/vagrant_2.0.1_x86_64.rpm'
	action :install
end

file '/tmp/vagrant_2.0.1_x86_64.rpm' do
	action :delete
end
