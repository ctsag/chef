require 'spec_helper'

describe 'nothingness::docker' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::users')
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::virtualbox')
  end

  it 'includes the users and virtualbox recipes' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::users')
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::virtualbox')
    chef_run
  end

  it 'purges vanilla docker packages' do
    purged_packages = [
      'docker',
      'docker-common',
      'docker-selinux',
      'docker-engine',
    ]

    purged_packages.each do |package_name|
      expect(chef_run).to purge_package(package_name)
    end
  end

  it 'creates the Docker yum repository' do
    expect(chef_run).to create_yum_repository('docker').with(
      description: 'Docker yum repository',
      baseurl: 'https://download.docker.com/linux/centos/7/$basearch/stable',
      gpgkey: 'https://download.docker.com/linux/centos/gpg'
    )
  end

  it 'installs Docker CE and suggested packages' do
    installed_packages = [
      'device-mapper-persistent-data',
      'lvm2',
      'docker-ce',
    ]

    installed_packages.each do |package_name|
      expect(chef_run).to install_package(package_name)
    end
  end

  it 'downloads and installs Docker Compose' do
    expect(chef_run).to create_remote_file('/usr/local/bin/docker-compose').with(
      source: 'https://github.com/docker/compose/releases/download/1.17.1/docker-compose-Linux-x86_64',
      owner: 'root',
      group: 'root',
      mode: '0755'
    )
  end

  it 'downloads and installs Docker Machine' do
    expect(chef_run).to create_remote_file('/usr/local/bin/docker-machine').with(
      source: 'https://github.com/docker/machine/releases/download/v0.13.0/docker-machine-Linux-x86_64',
      owner: 'root',
      group: 'root',
      mode: '0755'
    )
  end

  it 'adds the default user to the docker group' do
    expect(chef_run).to create_group('docker').with(
      members: ['ctsag'],
      append: true
    )
  end

  it 'starts and enables the docker service' do
    expect(chef_run).to enable_service('docker')
    expect(chef_run).to start_service('docker')
  end
end
