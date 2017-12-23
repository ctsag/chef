# Have all the essential packages been installed?
packages = [
  'epel-release',
  'git',
  'vim-enhanced',
  'wget',
  'yum-utils',
  'bash-completion',
  'tree',
  'net-tools',
  'nmap',
  'bind-utils',
  'telnet',
  'strace',
  'colordiff',
]

packages.each do |package_name|
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
