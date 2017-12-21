require 'spec_helper'

describe 'nothingness::httpd' do
	let(:chef_run) do
		runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
		runner.converge(described_recipe)
	end

	it 'converges successfully' do
		expect { chef_run }.to_not raise_error
	end

	it 'installs httpd' do
		expect(chef_run).to install_package 'httpd'
	end

	it 'enables the httpd service' do
		expect(chef_run).to enable_service 'httpd'
	end

	it 'starts the httpd service' do
		expect(chef_run).to start_service 'httpd'
	end
end
