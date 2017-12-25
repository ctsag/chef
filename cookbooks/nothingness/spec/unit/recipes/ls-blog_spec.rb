require 'spec_helper'

describe 'nothingness::ls-blog' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::httpd')
  end

  it 'includes the httpd recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::httpd')
    chef_run
  end

  it 'creates the directory structure for the ls-blog site' do
    directories = [
      '/srv/www/ls-blog',
      '/srv/www/ls-blog/logs',
      '/srv/www/ls-blog/public',
    ]

    directories.each do |dir|
      expect(chef_run).to create_directory(dir).with(
        owner: 'ctsag',
        group: 'ctsag',
        mode: '0755'
      )
    end
  end

  it "puts the site's vhost configuration in place" do
    expect(chef_run).to create_template('/etc/httpd/conf.d/ls-blog.conf').with(
      source: 'vhost_ls-blog.conf.erb'
    )
  end

  it 'restarts the httpd service' do
    expect(chef_run).to restart_service('httpd')
  end

  it 'puts a demo page in place' do
    expect(chef_run).to create_cookbook_file('/srv/www/ls-blog/public/index.html').with(
      source: 'ls-blog_index.html',
      owner: 'ctsag',
      group: 'ctsag'
    )
  end
end
