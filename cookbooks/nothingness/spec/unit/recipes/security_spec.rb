require 'spec_helper'

describe 'nothingness::security' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'puts the sshd configuration in place' do
    expect(chef_run).to create_cookbook_file('/etc/ssh/sshd_config').with(
      source: 'sshd_config'
    )
  end

  it 'restarts the sshd service' do
    expect(chef_run).to restart_service('sshd')
  end
end
