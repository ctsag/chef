# Has the base directory for the ls-blog site been put in place?
describe directory('/srv/www/ls-blog') do
	it { should exist }
	its('owner') { should eq 'ctsag' }
	its('group') { should eq 'ctsag' }
	its('mode') { should cmp '0755' }
end

# Has the log directory for the ls-blog site been put in place?
describe directory('/srv/www/ls-blog/logs') do
	it { should exist }
	its('owner') { should eq 'ctsag' }
	its('group') { should eq 'ctsag' }
	its('mode') { should cmp '0755' }
end

# Has the content directory for the ls-blog site been put in place?
describe directory('/srv/www/ls-blog/public') do
	it { should exist }
	its('owner') { should eq 'ctsag' }
	its('group') { should eq 'ctsag' }
	its('mode') { should cmp '0755' }
end

# Has the vhost configuration been put in place?
describe file('/etc/httpd/conf.d/nothingness.conf') do
	it {should exist }
end

# Is the httpd running?
describe service('httpd') do
	it { should be_running }
end

# Has the demo page been put in place?
describe command('curl localhost') do
	its('stdout') { should match /Hello, nothingness!/ }
end
