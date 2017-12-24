# Has the necessary package been installed?
describe package(node['packages']['vagrant']['name']) do
  it { should be_installed }
end

# Has the Vagrant artifact been deleted?
describe file("#{Chef::Config[:file_cache_path]}/#{node['packages']['vagrant']['name']}.rpm") do
  it { should_not exist }
end
