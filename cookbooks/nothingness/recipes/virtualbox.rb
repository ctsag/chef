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
