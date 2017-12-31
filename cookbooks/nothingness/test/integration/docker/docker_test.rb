# Export node attributes
require 'json'
node = json('/run/chef_node.json')

# Have the vanilla docker packages been removed?
node['default']['pkg']['docker']['purged'].each do |package_name|
  describe package(package_name) do
    it { should_not be_installed }
  end
end

# Has the official docker repository been installed?
describe yum.repo('docker') do
  it { should exist }
  it { should be_enabled }
end

# Have all the necessary packages been installed?
node['default']['pkg']['docker']['installed'].each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

# Has docker-compose been installed?
describe file('/usr/local/bin/docker-compose') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

# Has docker-machine been installed?
describe file('/usr/local/bin/docker-machine') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

# Has the default user been added to the docker group?
describe user('ctsag') do
  its('groups') { should include 'docker' }
end

# Has the docker service been enabled and is it running?
describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end
