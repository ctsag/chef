# Setting up a Chef Server

First, update all yum repositories

```bash
yum update
```

Then, install the Chef Server rpm detailed in https://downloads.chef.io/chef-server, e.g.

```bash
yum install https://packages.chef.io/files/stable/chef-server/12.17.15/el/7/chef-server-core-12.17.15-1.el7.x86_64.rpm
```

When working on a local Chef Server with no resolvable public static IP, we need to add this to the file /etc/opscode/chef-server.rb :

```ruby
server_name = 'proudhon.nothingness.gr'
api_fqdn = 'nothingness.zapto.org'
bookshelf['vip'] = server_name
nginx['url'] = "https://#{server_name}"
nginx['server_name'] = server_name
nginx['ssl_port'] = '449'
nginx['non_ssl_port'] = '450'
lb['fqdn'] = api_fqdn
```

And now we're free to configure our server

```bash
chef-server-ctl reconfigure
```

Once that's done with no errors, we can test whether everything's fine :

```bash
curl -D - 'http://localhost:8000/_status' | grep "200 OK"
```

This might need a couple of minuts before it starts working, but usually that's not the case.

Now we need to create our administrative user and our organization :

```bash
chef-server-ctl user-create chefadmin Chef Admin chrtsago@yahoo.gr insecureword --filename chefadmin.pem
chef-server-ctl org-create nothingness "Nothingness" --association_user chefadmin --filename nothingness-validator.pem
```

Last thing in line for the server, open up the http and https ports

```bash
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
systemctl restart firewalld
```

# Setting up a Chef Workstation

Now, from the workstation intended to control Chef Server via knife commands, copy over the chefadmin.pem file :

```bash
scp root@proudhon:~/chefadmin.pem . 
```

Still on the workstation, fetch the SSL certificate

```bash
knife ssl fetch
```

And verify they work fine

```bash
knife ssl check
```

# Bootstrapping nodes

Now, begin by uploading berks dependencies

```bash
berks install
berks upload --no-freeze
```

Then, upload the coobooks

```bash
knife cookbook upload nothingness
```

Create roles

```bash
knife role from file roles/*
```

Create environments

```bash
knife environment from file environments/*
```

Now, finally bootstrap a node

```bash
knife bootstrap proudhon.nothingness.gr --ssh-user root -ssh-password 'insecureword' --node-name proudhon --run-list 'role[admin]' --environment admin
```

From now on, you can run the Chef client remotely to execute the node's run list

```bash
knife ssh 'name:proudhon' 'chef-client' --ssh-user root --ssh-password 'insecureword'
```
