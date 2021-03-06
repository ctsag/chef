# Setting up a Chef Server

First, update all yum repositories.

```bash
yum update
```

Start by installing the Chef Development Kit rpm detailed in , https://downloads.chef.io/chefdk e.g.

```bash
yum install https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm
```

Then, install the Chef Server rpm detailed in https://downloads.chef.io/chef-server, e.g.

```bash
yum install https://packages.chef.io/files/stable/chef-server/12.17.15/el/7/chef-server-core-12.17.15-1.el7.x86_64.rpm
```

When working on a local Chef Server with no resolvable public static IP, we need to add this to the file /etc/opscode/chef-server.rb :

```ruby
nginx['server_name'] = "proudhon.nothingness.gr"
lb['api_fqdn'] = "proudhon.nothingness.gr"
nginx['url'] = "https://proudhon.nothingness.gr"
nginx['enable_non_ssl'] = true
nginx['ssl_port'] = 4443
nginx['non_ssl_port'] = 4444
bookshelf['url'] = "https://proudhon.nothingness.gr"
bookshelf['vip_port'] = 4443
```

And now we're free to configure our server.

```bash
chef-server-ctl reconfigure
```

Once that's done with no errors, we can test whether everything's fine :

```bash
curl -D - 'http://localhost:8000/_status' | grep "200 OK"
```

This might need a couple of minutes before it starts working, but usually that's not the case.

Now we need to create our administrative user and our organization :

```bash
chef-server-ctl user-create chefadmin Chef Admin chrtsago@yahoo.gr insecureword --filename chefadmin.pem
chef-server-ctl org-create nothingness "Nothingness" --association_user chefadmin --filename nothingness-validator.pem
```

Last thing in line for the server, open up the http and https ports

```bash
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=443/tcp --permanent
firewall-cmd --add-port=4443/tcp --permanent
firewall-cmd --add-port=4444/tcp --permanent
systemctl restart firewalld
```
