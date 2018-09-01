# Working with Test Kitchen

## Introduction

Test Kitchen is a QA framework for Chef cookbooks. It enables you to run your cookbooks in a temporary environment, 
like an ad-hoc VM set up by Vagrant and VirtualBox. A set of functional tests can then be run on this environment
that can validate the integrity of the cookbook. The entire operation is described in the .kitchen.yml file.

## Working with the Kitchen CLI

Listing Kitchen instances

```bash
cd ~/chef/cookbooks/nothingness
kitchen list
```

Creating all Kitchen instances (this will probably take a while)

```bash
cd ~/chef/cookbooks/nothingness
kitchen create
```
