# Export node attributes
require 'json'
node = json('/tmp/kitchen/chef_node.json')

# Have all the essential packages been installed?
node['default']['pkg']['essential'].each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

# Has SELinux been disabled?
describe command('getenforce') do
  its('stdout') { should_not cmp 'Enabled' }
end

# Has the timezone been set to Athens, Greece?
timezone = %r{Europe/Athens}
describe command('timedatectl | grep "Time zone:"') do
  its('stdout') { should match timezone }
end

# Has the maven profile been put in place?
describe file('/etc/profile.d/maven.sh') do
  it { should exist }
end

# Has the firewalld service been started and enabled?
describe service('firewalld') do
  it { should be_enabled }
  it { should be_running }
end

# Has the postfix service been stopped and disabled?
describe service('postfix') do
  it { should_not be_enabled }
  it { should_not be_running }
end
