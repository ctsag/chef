# Has the sshd configuration been put in place?
describe file('/etc/ssh/sshd_config') do
  it { should exist }
end

# Is the sshd service running?
describe service('sshd') do
  it { should be_running }
end
