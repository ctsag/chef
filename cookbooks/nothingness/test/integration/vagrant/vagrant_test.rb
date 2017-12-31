# Export node attributes
require 'json'
node = json('/run/chef_node.json')

# Has the necessary package been installed?
describe package(node['default']['pkg']['vagrant']['name']) do
  it { should be_installed }
end
