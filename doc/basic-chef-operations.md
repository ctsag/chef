# Basic Chef Operations

## Working with cookbooks

Generating a new cookbook

```bash
cd ~/chef
chef generate cookbook cookbooks/nothingness
```

Generating a new chef entity, a template for instance

```bash
cd ~/chef
chef generate template cookbooks/nothingness index.html
```

Listing uploaded cookbooks

```bash
cd ~/chef
knife cookbook
```

Make sure to update the version of the cookbook in the metadata file anytime you upload it

```bash
cd ~/chef/cookbooks/nothingness
vi metadata.rb
```

And the, actually upload the cookbook

```bash
cd ~/chef
knife cookbook list
```

Propagating a new or updated cookbook to a bootstrapped node

```bash
cd ~/chef/cookbooks/nothingness
knife ssh 'name:proudhon' 'chef-client' --ssh-user root
```

## Working with nodes

Listing nodes

```bash
cd ~/chef
knife node list
```

Querying a single node

```bash
cd ~/chef
knife node show proudhon
```
