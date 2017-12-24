# Has the directory structure for the ls-blog site been put in place?
directories = [
  '/srv/www/ls-blog',
  '/srv/www/ls-blog/logs',
  '/srv/www/ls-blog/public',
]

directories.each do |dir|
  describe directory(dir) do
    it { should exist }
    its('owner') { should eq 'ctsag' }
    its('group') { should eq 'ctsag' }
    its('mode') { should cmp '0755' }
  end
end

# Has the vhost configuration been put in place?
describe file('/etc/httpd/conf.d/ls-blog.conf') do
  it { should exist }
end

# Is the httpd service running?
describe service('httpd') do
  it { should be_running }
end

# Has the demo page been put in place?
describe command('curl --resolve ls-blog.dev.nothignness.gr:127.0.0.1 http://ls-blog.dev.nothingness.gr') do
  its('stdout') { should match /Hello, nothingness!/ }
end
