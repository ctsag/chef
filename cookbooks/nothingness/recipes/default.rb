# Install essential packages
node['packages']['essential'].each do |package_name|
  package package_name
end

# Disable SELinux
cookbook_file '/etc/selinux/config' do
  source 'selinux_config'
end

execute 'selinux_disable' do
  command 'setenforce 0'
  returns [0, 1]
end

# Set the timezone to Athens, Greece
execute 'timezone_Athens' do
  command 'timedatectl set-timezone "Europe/Athens"'
end

# Start and enable the firewalld service
service 'firewalld' do
  action [:enable, :start]
end

# Stop the postfix service
service 'postfix' do
  action [:stop, :disable]
end
