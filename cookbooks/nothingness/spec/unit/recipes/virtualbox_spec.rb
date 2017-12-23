require 'spec_helper'

describe 'nothingness::virtualbox' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'creates the VirtualBox yum repository' do
    expect(chef_run).to create_yum_repository('virtualbox').with(
      description: 'VirtualBox yum repository',
      baseurl: 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch',
      gpgkey: 'https://www.virtualbox.org/download/oracle_vbox.asc'
    )
  end

  it 'installs VirtualBox and suggested packages' do
    packages = [
      'kernel-devel',
      'gcc',
      'VirtualBox-5.2',
    ]

    packages.each do |package_name|
      expect(chef_run).to install_package(package_name)
    end
  end

  it 'rebuilds and loads the VirtualBox kernel module' do
    expect(chef_run).to run_execute('/sbin/vboxconfig')
  end
end
