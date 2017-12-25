require 'spec_helper'

describe 'nothingness::jenkins' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'creates the Jenkins yum repository' do
    expect(chef_run).to create_yum_repository('jenkins').with(
      description: 'Jenkins yum repository',
      baseurl: 'http://pkg.jenkins.io/redhat-stable',
      gpgkey: 'https://pkg.jenkins.io/redhat-stable/jenkins.io.key'
    )
  end

  it 'installs the Jenkins package' do
    expect(chef_run).to install_package('jenkins')
  end

  it 'enables and starts the Jenkins service' do
    expect(chef_run).to enable_service('jenkins')
    expect(chef_run).to start_service('jenkins')
  end

  it 'opens up the Jenkins port' do
    expect(chef_run).to run_execute('firewall-cmd --add-port=8080/tcp --permanent')
  end

  it "puts the site's vhost configuration in place" do
    expect(chef_run).to create_template('/etc/httpd/conf.d/jenkins.conf').with(
      source: 'vhost_jenkins.conf.erb'
    )
  end

  it 'restarts the httpd service' do
    expect(chef_run).to restart_service('httpd')
  end
end
