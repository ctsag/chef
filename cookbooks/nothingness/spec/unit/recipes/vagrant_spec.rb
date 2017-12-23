require 'spec_helper'

describe 'nothingness::vagrant' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::virtualbox')
  end

  it 'includes the virtualbox recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::virtualbox')
    chef_run
  end

  it 'downloads the Vagrant rpm' do
    expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/vagrant_2.0.1_x86_64.rpm").with(
      source: 'https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.rpm'
    )
  end

  it 'installs the Vagrant rpm' do
    expect(chef_run).to install_package('vagrant')
  end

  it 'deletes the Vagrant rpm' do
    expect(chef_run).to delete_remote_file("#{Chef::Config[:file_cache_path]}/vagrant_2.0.1_x86_64.rpm")
  end
end
