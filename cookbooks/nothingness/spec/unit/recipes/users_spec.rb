require 'spec_helper'

describe 'nothingness::users' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'creates the default user' do
    expect(chef_run).to create_user('ctsag').with(
      manage_home: true,
      home: '/home/ctsag',
      shell: '/bin/bash',
      password: '$1$4G0dL9.P$b//V0sro19xF3CmVc2rcY.'
    )
  end

  it 'adds the default user to the wheel group' do
    expect(chef_run).to modify_group('wheel').with(
      members: ['ctsag'],
      append: true
    )
  end

  it 'puts rc files in place' do
    files = {
      'home_bashrc' => '.bashrc',
      'home_inputrc' => '.inputrc',
      'home_virc' => '.virc',
      'home_vimrc' => '.vimrc',
    }

    users = {
      'root' => '/root',
      'ctsag' => '/home/ctsag',
    }

    users.each do |user, home_dir|
      files.each do |source_file, target_file|
        expect(chef_run).to create_cookbook_file("#{home_dir}/#{target_file}").with(
          source: source_file,
          owner: user,
          group: user
        )
      end
    end
  end
end
