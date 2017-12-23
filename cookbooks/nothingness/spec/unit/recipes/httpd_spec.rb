require 'spec_helper'

describe 'nothingness::httpd' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::default')
  end

  it 'includes the default recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::default')
    chef_run
  end

  it 'installs the httpd package' do
    expect(chef_run).to install_package('httpd')
  end

  it 'puts the httpd configuration in place' do
    expect(chef_run).to create_cookbook_file('/etc/httpd/conf/httpd.conf').with(
      source: 'httpd.conf'
    )
  end

  it 'creates the httpd content directory structure' do
    directories = [
      '/srv/www',
      '/srv/www/default',
    ]

    directories.each do |dir|
      expect(chef_run).to create_directory(dir).with(
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end

  it 'opens up the http port' do
    expect(chef_run).to run_execute('firewall-cmd --add-port=80/tcp --permanent')
  end

  it 'opens up the https port' do
    expect(chef_run).to run_execute('firewall-cmd --add-port=443/tcp --permanent')
  end

  it 'starts and enables the httpd service' do
    expect(chef_run).to enable_service('httpd')
    expect(chef_run).to start_service('httpd')
  end
end
