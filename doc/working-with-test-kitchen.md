# Working with Test Kitchen

## Introduction

Test Kitchen is a QA framework for Chef cookbooks. It enables you to run your cookbooks in a temporary environment, 
like an ad-hoc VM set up by Vagrant and VirtualBox. A set of functional tests can then be run on this environment
that can validate the integrity of the cookbook. The entire operation is described in the .kitchen.yml file.

## Limitations

There are a couple of downsides to this method of testing. The first one is virtualization. If you're working on VMs already, having to spawn Vagrant/VirtualBox instances inside that VM means we're treading into nested virtualization waters. This in turn limits the options we have in terms of VM platforms for the outside VMs. Currently, VMWare and Hyper-V both support nested virtualization.

The second limitation is similar but simpler. Nested VMs mean the environment that hosts all these needs to carry some decent RAM. Since we need Kitchen testing to run on both the administration server and the development box, that's a total of 6 to 8 gigs of RAM and even that might not be enough. This in turns forces us to think about QA strategy. Each test suite requires its own VM. So, either we attempt to configure those VMs to take less memory or we start with only one test suite that tests everyhing and only create a second one if we have no other choice.

## VirtualBox prep step

VirtualBox runs on kernel drivers. Building and loading them requires the following command to be executed

```bash
/sbin/vboxconfig
```

Unfortunately, for this to run you'll need to install the kernel-devel package and then reboot and only after that can your this command. This reboot step makes automating this step tricky.

## Working with the Kitchen CLI

Listing Kitchen instances

```bash
cd ~/chef/cookbooks/nothingness
kitchen list
```

Creating all Kitchen instances (this will probably take a while). We can work with a specific instance by providing its name or part of it as an argument, otherwise this will create all instances.

```bash
cd ~/chef/cookbooks/nothingness
kitchen create
```

Next up, converge. This step provisions the run lists defined in your .kitchen.yml file/

```bash
cd ~/chef/cookbooks/nothingness
kitchen converge
```

Now we can run the InSpec tests. Again, these are defined in the .kitchen.yml file.

```bash
cd ~/chef/cookbooks/nothingness
kitchen verify
```

Finally, let's destroy all Kitchen istnances

```bash
cd ~/chef/cookbooks/nothingness
kitchen destroy
```

## Running InSpec without Kitchen

TODO
