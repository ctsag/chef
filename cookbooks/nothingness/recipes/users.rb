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
files = {
	'home_bashrc' => '.bashrc',
	'home_inputrc' => '.inputrc',
	'home_virc' => '.virc',
	'home_vimrc' => '.vimrc'
}

users = {
	'root' => '/root/',
	'ctsag' => '/home/ctsag/'
}

users.each do |user, home_dir|
	files.each do |source_file, target_file|
		cookbook_file home_dir + target_file do
			source source_file
			owner user
			group user
		end
	end
end
