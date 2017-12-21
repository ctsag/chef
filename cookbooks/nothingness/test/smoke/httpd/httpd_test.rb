# Has the httpd package been installed?
describe package('httpd') do
  it { should be_installed }
end

# Has the httpd content directory been put in place?
describe directory('/srv/www') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

# Has the content directory for the default site been put in place?
describe directory('/srv/www/default') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

# Has the port for http been opened up?
describe port(80) do
  it { should be_listening }
end

# Has the port for https been opened up?
describe port(443) do
  it { should be_listening }
end

# Has the httpd service been enabled and is it running?
describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end
