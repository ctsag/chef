require 'spec_helper'

describe 'nothingness::default' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'installs essential packages' do
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
      'colordiff',
      'java-1.8.0-openjdk',
      'ant',
      'maven',
    ]

    packages.each do |package_name|
      expect(chef_run).to install_package(package_name)
    end
  end

  it 'disables SELinux' do
    expect(chef_run).to create_cookbook_file('/etc/selinux/config').with(
      source: 'selinux_config'
    )
    expect(chef_run).to run_execute('setenforce 0').with(
      returns: [0, 1]
    )
  end

  it 'sets the timezone to Athens, Greece' do
    expect(chef_run).to run_execute('timedatectl set-timezone "Europe/Athens"')
  end

  it 'sets the global user full name for git' do
    expect(chef_run).to run_execute('git config --global user.name "Christos Tsagkournis"')
  end

  it 'sets the global user email for git' do
    expect(chef_run).to run_execute('git config --global user.email "chrtsago@yahoo.gr"')
  end

  it 'enables and starts the firewalld service' do
    expect(chef_run).to enable_service('firewalld')
    expect(chef_run).to start_service('firewalld')
  end

  it 'stops and disables the postfix service' do
    expect(chef_run).to stop_service('postfix')
    expect(chef_run).to disable_service('postfix')
  end
end
