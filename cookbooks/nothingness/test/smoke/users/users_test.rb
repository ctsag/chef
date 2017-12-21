# Has the default user been created?
describe user('ctsag') do
	it { should exist }
	its('home') { should eq '/home/ctsag' }
	its('shell') { should eq '/bin/bash' }
end

# Has the default user's password been properly set?
describe shadow.users('ctsag') do
	its('passwords') { should include '$1$4G0dL9.P$b//V0sro19xF3CmVc2rcY.' }
end

# Has the default user's home directory been created?
describe directory('/home/ctsag') do
	it { should exist }
end

# Has the default user been added to the wheel group?
describe user('ctsag') do
	its('groups') { should include 'wheel' }
end

# Have the rc files been put in place?
user_dirs = [
	'/root/',
	'/home/ctsag/'
]

rc_files = [
	'.bashrc',
	'.inputrc',
	'.virc',
	'.vimrc'
]

user_dirs.each do |user_dir|
	rc_files.each do |rc_file|
		describe file(user_dir + rc_file) do
			it { should exist }
		end
	end
end
