user 'ctsag' do
	manage_home true
	home '/home/ctsag'
	shell '/bin/bash'
	password '$1$4G0dL9.P$b//V0sro19xF3CmVc2rcY.'
	action :create
end

group 'wheel' do
	members 'ctsag'
	append true
	action :modify
end

cookbook_file '/home/ctsag/.bashrc' do
	source 'home_bashrc'
end

cookbook_file '/home/ctsag/.inputrc' do
	source 'home_inputrc'
end

cookbook_file '/home/ctsag/.virc' do
	source 'home_virc'
end

cookbook_file '/home/ctsag/.vimrc' do
	source 'home_vimrc'
end

