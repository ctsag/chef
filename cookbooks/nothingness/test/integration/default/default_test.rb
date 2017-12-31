# Export node attributes
require 'json'
node = json('/var/chef/chef_node.json')

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

# Has the global user full name for git been set?
describe command('git config --get user.name') do
  its('stdout') { should match /Christos Tsagkournis/ }
end

# Has the global user email for git been set?
describe command('git config --get user.email') do
  its('stdout') { should match /chrtsago@yahoo.gr/ }
end

# Has the global color setting for git been set?
describe command('git config --get color.ui') do
  its('stdout') { should match /auto/ }
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
