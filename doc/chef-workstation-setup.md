# Setting up a Chef Workstation

## Preparation

First, update all yum repositories.

```bash
yum update
```

Now, install git.

```bash
yum install git
```

Next, configure git.

```bash
git config --global user.name "ctsag"
git config --global user.email "chrtsago@yahoo.gr"
```

Generate a SSH public key.

```bash
ssh-keygen -t rsa -b 4096 -C "ctsag@decleyre.nothingness.gr"
```

And add the contents of `~/.ssh/id_rsa.pub` to the SSH keys on your github account settings.

We can now clone the chef cookbook, like this :

```bash
cd ~
git clone git@github.com:ctsag/chef.git
```

## Setting up a Chef Workstation

Just like with the Chef Server, start by installing the Chef Development Kit rpm detailed in , https://downloads.chef.io/chefdk e.g.

```bash
yum install https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm
```

Now, from the workstation intended to control Chef Server via knife commands, copy over the `chefadmin.pem` file :

```bash
scp root@proudhon:~/chefadmin.pem ~/chef/.chef/
```

Still on the workstation, fetch the SSL certificates.

```bash
cd ~/chef
knife ssl fetch
```

And verify they work fine.

```bash
cd ~/chef
knife ssl check
```

## Bootstrapping nodes

Now, begin by installing (but not uploading) cookbooks used for local testing.

```bash
cd ~/chef/cookbooks/nothingness
berks install
```

Then, upload the coobook.

```bash
cd ~/chef
knife cookbook upload nothingness
```

Create roles.

```bash
cd ~/chef/cookbooks/nothingness
knife role from file roles/*
```

Create environments.

```bash
cd ~/chef/cookbooks/nothingness
knife environment from file environments/*
```

Copy your SSH public key to all the nodes for the root user and, optionally, for the non-root user as well.

```bash
ssh-copy-id ctsag@proudhon
ssh copy-id root@proudhon
```

Now, finally bootstrap a node.

```bash
cd ~/chef/cookbooks/nothingness
knife bootstrap proudhon.int.nothingness.gr --ssh-user root --node-name proudhon --run-list 'role[admin]' --environment admin
```

From now on, you can run the Chef client remotely to execute the node's run list.

```bash
cd ~/chef/cookbooks/nothingness
knife ssh 'name:proudhon' 'chef-client' --ssh-user root
```
