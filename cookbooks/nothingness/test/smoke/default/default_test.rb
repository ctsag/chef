# Are all the essential packages installed?
packages = [
	'epel-release',
	'git',
	'vim-enhanced',
	'wget',
	'yum-utils',
	'bash-completion',
	'tree',
	'net-tools',
	'nmap',
	'bind-utils',
	'telnet',
	'strace',
	'colordiff'
]

packages.each do |package_name|
	describe package(package_name) do
		it { should be_installed }
	end
end

# Is SELinux disabled?

# Is the timezone set to Athens, Greece?

# Is the postfix service stopped and disabled?
describe service('postfix') do
	it { should_not be_enabled }
	it { should_not be_running }
end
