include_recipe 'nothingness::virtualbox'

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
