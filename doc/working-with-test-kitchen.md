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

The entire lifecycle of a Kitchen instance, that is, all steps described above, can be summarized into one command

```bash
cd ~/chef/cookbooks/nothingness
kitchen test
```

This will create an instance, apply the runlist, run the tests and tear down the instance, which makes it ideal for automated scenarios, such as a Jenkins job.

## A note on Kitchen lifecycle

One thing to keep in mind when working with Kitchen is this. Suppose one of your tests is failing. What you'll do is either make changes to the test or make changes to the recipe, or both. When you're only modifying the tests, rerunning kitchen verify works fine. If you're modifying the recipe however, you'll need to rerun kitchen converge, to have the new recipe applied. Might seem trivial but it's easy to forget.

## Running InSpec without Kitchen

InSpec is not limited within the confines of Kitchen or Chef. Instead, it can be run in standalone mode and can execute tests both on localhost and on remote hosts. What's really powerful about this is that you can inspect a remote host without having to install anything on it.

To run a single test suite on localhost

```bash
cd ~/chef/cookbooks/nothingness
inspec exec test/integration/users/users_test.rb
```

Let's try to run this test on a remote node. For the moment, the InSpec CLI seems to only be able to establish SSH connections via the ssh-agent. So, before any remote tests can be run, we need to start the ssh-agent and add our private key. You'll need to run both statements below each time at the start of your InSpec testing session, unless you want ssh-agent running as a service

```bash
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
```

We can then execute our tests on a remote host, like this

```bash
cd ~/chef/cookbooks/nothingness
inspec exec test/integration/users/users_test.rb -t 'ssh://root@goldman'
```

To have InSpec detect basic node attributes

```bash
inspec detect
```

There's a lot more to the InSpec CLI, so giving its documentation a look is worth it

## Further reading

- [Test driven development with InSpec](https://learn.chef.io/modules/tdd-with-inspec#/local-development-and-testing/)
- [Try InSpec](https://learn.chef.io/modules/try-inspec#/)
- [InSpec tutorials](https://www.inspec.io/tutorials/)
