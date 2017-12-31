ruby_block 'Save node attributes' do
  block do
    IO.write('/run/chef_node.json', node.to_json)
  end
end
