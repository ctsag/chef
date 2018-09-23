# Basic Chef operations

## Working with cookbooks

Generate a new cookbook.

```bash
cd ~/chef
chef generate cookbook cookbooks/nothingness
```

Generate a new chef entity, a template for instance.

```bash
cd ~/chef
chef generate template cookbooks/nothingness index.html
```

List uploaded cookbooks.

```bash
cd ~/chef
knife cookbook list
```

Make sure to update the version of the cookbook in the metadata file anytime you upload it.

```bash
cd ~/chef/cookbooks/nothingness
vi metadata.rb
```

And then, to actually upload the cookbook.

```bash
cd ~/chef
knife cookbook upload nothingness
```

An even better way to upload cookbooks, however, is via the Berkshelf facility. The advantage to this is that Berkshelf also handles cookbook dependencies. More on that later within this document.

Here's how to list all uploaded cookbooks.

```bash
cd ~/chef
knife cookbook list
```

Propagate a new or updated cookbook to a bootstrapped node.

```bash
cd ~/chef/cookbooks/nothingness
knife ssh 'name:proudhon' 'chef-client' --ssh-user root
```

Delete an uploaded cookbook.

```bash
cd ~/chef
knife cookbook delete nothingness --all
```

## Working with nodes and roles

Listing nodes.

```bash
cd ~/chef
knife node list
```

Querying a single node.

```bash
cd ~/chef
knife node show proudhon
```

Deleting a node and the Chef client for that node.

```bash
cd ~/chef
knife node delete proudhon
knife client delete proudhon
```
Listing roles.

```bash
cd ~/chef
knife role list
```

Querying a single role.

```bash
cd ~/chef
knife role show admin
```

Deleting a role.

```bash
cd ~/chef
knife role delete admin
```

Running the Chef client for all the nodes registered to a role.

```bash
cd ~/chef
knife ssh 'role:admin' 'chef-client' --ssh-user root
```

Finally, here's how you query the status of all nodes. The query can be refined by node or role name, but this is how you get everything.

```bash
cd ~/chef
knife status --run-list
```

## Working with Berskshelf

Berkshelf is a toolset that allows a Chef administrator to interact with the Chef Supermarket, a repository of publicly shared cookbooks.
You can also create your own private Supermarket. An additional benefit of working with Berkshelf is that it is able to resolve dependencies automatically.

First, make sure a Berskfile is present and configured.

```vim
# frozen_string_literal: true
source 'https://supermarket.chef.io'
metadata
```

Now, fetch the cookbook index from the Chef Supermarket.

```bash
cd ~/chef/cookbooks/nothingness
berks install
```

If you wanted to fetch a cookbook from the Supermarket, you'd add the following line to the Berskfile file, at the top level directory of your cookbook.

```vim
cookbook 'logrotate'
```

Running `berks install` would then install this cookbook under ~/.berkshelf/cookbooks.

You can then upload these cookbooks to your Chef server, like this.

```bash
cd ~/chef/cookbooks/nothingness
berks upload --no-ssl-verify
```

This is a better option than `knife coobook upload` because it also handles dependencies.

## Working with knife opc

TODO
