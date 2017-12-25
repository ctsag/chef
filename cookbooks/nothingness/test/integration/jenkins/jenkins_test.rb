# Has the official Jenkins repository been installed?
describe yum.repo('jenkins') do
  it { should exist }
  it { should be_enabled }
end

# Has the Jenkins package been installed?
describe package('jenkins') do
  it { should be_installed }
end

# Has the Jenkins service been enabled and started?
describe service('jenkins') do
  it { should be_enabled }
  it { should be_running }
end

# Has the Jenkins port been opened up?
describe port(8080) do
  it { should be_listening }
end

# Has the site's vhost configuration been put in place?
describe file('/etc/httpd/conf.d/jenkins.conf') do
  it { should exist }
end

# Is the httpd service running?
describe service('httpd') do
  it { should be_running }
end

# Is the vhost working?
describe command("curl --resolve jenkins#{node['host_context']}.nothignness.gr:127.0.0.1 http://jenkins#{node['host_context']}.nothingness.gr") do
  its('stdout') { should match /hudson.model/ }
end
