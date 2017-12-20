# Are all the essential packages installed?
packages = [
	'epel-release',
	'git',
	'vim',
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

# Are ports for ssh, http and https opened up?
ports = [
	22,
	80,
	443
]

ports.each do |port_number|
	describe port(port_number) do
		it { should be_listening }
	end
end

# Is the firewalld service running?
describe service('firewalld') do
	it { should be_running }
end

# Is the postfix service stopped and disabled?
describe service('postfix') do
	it { should be_disabled }
	it { should_not be_running }
end
