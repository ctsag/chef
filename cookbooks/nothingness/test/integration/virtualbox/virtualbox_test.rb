# Has the VirtualBox yum repository been installed?
describe yum.repo('virtualbox') do
  it { should exist }
  it { should be_enabled }
end

# Have all the necessary packages been installed?
node['packages']['virtualbox'].each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

# Has the VirtualBox kernel module been rebuilt and loaded?
describe command('lsmod | grep vbox') do
  its('exit_status') { should eq 0 }
end
