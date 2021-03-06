# Download and install Vagrant
remote_file "#{Chef::Config[:file_cache_path]}/#{node['pkg']['vagrant']['name']}.rpm" do
  source node['pkg']['vagrant']['source']
end

package node['pkg']['vagrant']['name'] do
  source "#{Chef::Config[:file_cache_path]}/#{node['pkg']['vagrant']['name']}.rpm"
end
