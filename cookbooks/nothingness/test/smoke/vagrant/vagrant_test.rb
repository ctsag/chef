# Has the necessary package been installed?
describe package('vagrant') do
  it { should be_installed }
end

# Has the Vagrant artifact been deleted?
describe file('/tmp/vagrant_*.rpm') do
  it { should_not exist }
end
