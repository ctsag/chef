require 'spec_helper'

describe 'nothingness::vagrant' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'downloads the Vagrant rpm' do
    expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/vagrant.rpm").with(
      source: 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm'
    )
  end

  it 'installs the Vagrant rpm' do
    expect(chef_run).to install_package('vagrant')
  end
end
