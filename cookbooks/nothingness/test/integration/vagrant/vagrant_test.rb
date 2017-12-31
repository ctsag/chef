# Export node attributes
require 'json'
node = json('/var/chef/chef_node.json')

# Has the necessary package been installed?
describe package(node['default']['pkg']['vagrant']['name']) do
  it { should be_installed }
end

# Has the Vagrant artifact been deleted?
describe file("#{Chef::Config[:file_cache_path]}/vagrant.rpm") do
  it { should_not exist }
end
