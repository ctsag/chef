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
files = [
	'.bashrc',
	'.inputrc',
	'.virc',
	'.vimrc'
]

users = {
	'root' => '/root/',
	'ctsag' => '/home/ctsag/'
}

users.each do |user, home_dir|
	files.each do |target_file|
		describe file(home_dir + target_file) do
			it { should exist }
			its('owner') { should eq user }
			its('group') { should eq user }			
		end
	end
end
