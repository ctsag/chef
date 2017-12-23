# Include the virtualbox recipe
include_recipe 'nothingness::virtualbox'

# Download and install Vagrant
remote_file "#{Chef::Config[:file_cache_path]}/vagrant_2.0.1_x86_64.rpm" do
  source 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm'
end

package 'vagrant' do
  source "#{Chef::Config[:file_cache_path]}/vagrant_2.0.1_x86_64.rpm"
  action :install
end

# Delete the downloaded Vagrant artifact
remote_file "#{Chef::Config[:file_cache_path]}/vagrant_2.0.1_x86_64.rpm" do
  action :delete
end
