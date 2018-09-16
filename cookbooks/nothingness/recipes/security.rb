# Put the sshd configuration in place
cookbook_file '/etc/ssh/sshd_config' do
  source 'sshd_config'
end

# Restart the sshd service
service 'sshd' do
  action [:restart]
end

# TODO: Modify the permissions for everything within ~/.ssh
