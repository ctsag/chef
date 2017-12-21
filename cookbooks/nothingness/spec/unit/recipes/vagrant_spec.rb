require 'spec_helper'

describe 'nothingness::vagrant' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end
