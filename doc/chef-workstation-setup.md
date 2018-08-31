# Preparation

First, update all yum repositories

```bash
yum update
```

Now, install git

```bash
yum install git
```

Next, configure git

```bash
git config --global user.name "ctsag"
git config --global user.email "chrtsago@yahoo.gr"
```

Generate a SSH public key

```bash
ssh-keygen -t rsa -b 4096 -C "ctsag@decleyre.nothingness.gr"
```

And add the contents of ~/.ssh/id_rsa.pub to the SSH keys on your github account settings

We can now clone the chef cookbook, for instance :

```bash
git clone git@github.com:ctsag/chef.git
```

# Setting up a Chef Workstation

Just like with the Chef Server, start by installing the Chef Development Kit rpm detailed in , https://downloads.chef.io/chefdk e.g.

```bash
yum install https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm
```

Now, from the workstation intended to control Chef Server via knife commands, copy over the chefadmin.pem file :

```bash
scp root@proudhon:~/chefadmin.pem ~/chef/.chef/
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

Now, begin by installing (but not uploading) cookbooks used for local testing

```bash
cd chef/cookbooks/nothingness
berks install
```

Then, upload the coobook

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

All knife SSH communications need to occur via SSH keys, so let's do this now. If you don't have a public key, create one now :

```bash
ssh-keygen -t rsa -b 4096 -C "ctsag@decleyre"
```

And now copy this key to all the nodes for the root user and, optionally, for the non-root user as well

```bash
ssh-copy-id ctsag@proudhon
ssh copy-id root@proudhon
```

Now, finally bootstrap a node

```bash
knife bootstrap proudhon.nothingness.gr --ssh-user root -ssh-password 'insecureword' --node-name proudhon --run-list 'role[admin]' --environment admin
```

From now on, you can run the Chef client remotely to execute the node's run list

```bash
knife ssh 'name:proudhon' 'chef-client' --ssh-user root --ssh-password 'insecureword'
```
