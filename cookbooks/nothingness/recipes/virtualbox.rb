# Create the official VirtualBox repository
yum_repository 'virtualbox' do
  description 'VirtualBox yum repository'
  baseurl node['repositories']['virtualbox']['baseurl']
  gpgkey node['repositories']['virtualbox']['gpgkey']
  action :create
end

# Install VirtualBox and suggested packages
node['pkg']['virtualbox'].each do |package_name|
  package(package_name)
end

# Rebuild and load the VirtualBox kernel module
execute 'vbox_config' do
  command '/sbin/vboxconfig'
end
