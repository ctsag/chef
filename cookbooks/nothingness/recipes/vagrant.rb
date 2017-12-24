# Include the virtualbox recipe
include_recipe 'nothingness::virtualbox'

# Download and install Vagrant
remote_file "#{Chef::Config[:file_cache_path]}/#{node['pkg']['vagrant']['name']}.rpm" do
  source node['pkg']['vagrant']['source']
end

package node['pkg']['vagrant']['name'] do
  source "#{Chef::Config[:file_cache_path]}/#{node['pkg']['vagrant']['name']}.rpm"
end

# Delete the downloaded Vagrant artifact
remote_file "#{Chef::Config[:file_cache_path]}/#{node['pkg']['vagrant']['name']}.rpm" do
  action :delete
end
