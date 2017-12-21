# Create the default user
user 'ctsag' do
	manage_home true
	home '/home/ctsag'
	shell '/bin/bash'
	password '$1$4G0dL9.P$b//V0sro19xF3CmVc2rcY.'
	action :create
end

# Add the default user to the wheel group
group 'wheel' do
	members 'ctsag'
	append true
	action :modify
end

# Put rc files in place
user_dirs = [
	'/root/',
	'/home/ctsag/'
]

user_dirs.each do |user_dir|
	cookbook_file user_dir + '.bashrc' do
		source 'home_bashrc'
	end

	cookbook_file user_dir + '.inputrc' do
		source 'home_inputrc'
	end

	cookbook_file user_dir + '.virc' do
		source 'home_virc'
	end

	cookbook_file user_dir + '.vimrc' do
		source 'home_vimrc'
	end
end
