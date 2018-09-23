# A test driven day at work with Chef

## Introduction

The purpose of this document is to describe a test driven workflow into writing a new recipe. It's assumed that a basic Chef insfrastructure is in place, that a cookbook has been created, that run lists have been assigned to nodes, roles or environments and that Test Kitchen and its dependencies (e.g. Vagrant and VirtualBox) have been configured and tested to work end to end.

We're also not going to deal with the semantics of specific Chef components such as ChefSpec, Kitchen, etc. Knowledge of how each component works and how to write code for it is heavily assumed.

So, let's figure out how to install and configure the Apache httpd server, using a test driven approach.

## Step 1 : Writing the unit tests

ChefSpec, Chef's rendition of RSpec, is used for unit testing. Unit tests are stored in the `spec/unit/recipes directory`, in files named `${recipe}_spec.rb`. Each file holds the entire suit of tests for a single recipe. Here's a skeleton test suite that simply tests whether the recipe successfully converges.

```ruby
require 'spec_helper'

describe 'nothingness::httpd' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

end
```

Before we go any further, notice how `ChefSpec::ServerRunner` is instantiated. It's being told that the platform is CentOS 7.4.1708. You can use ChefSpec contexts to create test suites for the same recipe but for different platforms. Apache httpd, for example, might need to be configured differently on Ubuntu. Keep this in mind, because we're not going to deal with multi platform testing in the document.

Now, ChefSpec uses the `expect` syntax of RSpec to declare expectations. With the boiler plate code above at hand we can now start adding what we expect our recipe to do. At this stage, we don't need to implement how these expectations are tested, just what we expect, in plain English. So, what do we expect an httpd recipe to do? We expect it to :

- install the Apache httpd package
- modify its configuration files to our preference
- set up the directory structure for the default website
- configure appropriate permissions for the default website directory structure
- configure the firewall to allow traffic for http and https ports
- enable and start the httpd service

So, here are these expectations added into the test suite.

```ruby
require 'spec_helper'

describe 'nothingness::httpd' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'installs the Apache httpd package'

  it 'modifies its configuration file to our preference'

  it 'sets up the directory structure for the default website'

  it 'configures appropriate permissions for the default website directory structure'

  it 'configures the firewall to allow traffic for http and https ports'

  it 'enables and starts the httpd service'

end
```

This simple step of declaring expectationss is key to why a test driven approach is a great way to work. By declaring our expectations we essentially break down and document the requirements of the task. We've taken a vague requirement such as "install a web server", broken it down into distinct subtasks and documented those subtasks clearly and concisely.

The next step is take the first unimplemented expectation and write down what conditions would prove that it has been fulfilled. Let's do that now for `installs the apache httpd package`. What do we expect? We expect Chef to install a package named httpd.

```ruby
it 'installs the Apache httpd package' do
  expect(chef_run).to install_package('httpd')
end
```

And it's as simple as that, almost plain English. At this point, we have two options. We can write the test implementations for our remaining expectations and then start writing recipe code that passes those tests, or we can iterate between writing one test at a time and then writing the code that makes this one test pass, until all expectations are fulfilled. For the sake of brevity, we'll take the latter approach in this document and focus only on the expectation referenced above, the installation of the httpd package. Then, at the end of the document, we'll take a look at how our complete test suit and recipe look like.

Before we move into writing the recipe that passes our test, let's have a quick look at our test suite.

```ruby
require 'spec_helper'

describe 'nothingness::httpd' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  it 'installs the Apache httpd package' do
    expect(chef_run).to install_package('httpd')
  end

  it 'modifies its configuration file to our preference'

  it 'sets up the directory structure for the default website'

  it 'configures appropriate permissions for the default website directory structure'

  it 'configures the firewall to allow traffic for http and https ports'

  it 'enables and starts the httpd service'

end
```

Now, let's take a look at what happens if run this test suite.

First, let's create an empty httpd recipe.

```bash
cd ~/chef/cookbooks/nothingness
touch recipes/httpd.rb
```

Now, let's run ChefSpec.

```bash
cd ~/chef/cookbooks/nothingness
chef exec rspec spec/unit/recipes/httpd_spec.rb
```

Here's the key part of the output.

```vim
nothingness::httpd
  converges successfully
  installs the Apache httpd package (FAILED - 1)
  modifies its configuration file to our preference (PENDING: Not yet implemented)
  sets up the directory structure for the default website (PENDING: Not yet implemented)
  configures appropriate permissions for the default website directory structure (PENDING: Not yet implemented)
  configures the firewall to allow traffic for http and https ports (PENDING: Not yet implemented)
  enables and starts the httpd service (PENDING: Not yet implemented)
```

There's a number of items of interest here :

- the expectation that the recipe converges succesfully passes
- the expectation that it installs the httpd package is marked as `FAILED`
- all unimplemented expectations are marked as `PENDING`

Further down the output we can see the reason for the failure.

```vim
Failures:

  1) nothingness::httpd installs the Apache httpd package
     Failure/Error: expect(chef_run).to install_package('httpd')

       expected "package[httpd]" with action :install to be in Chef run. Other package resources:
```

We can get a rough idea of what's expected to be found within our recipe, so let's move to the next step, which is to write just enough code to make that one failing test pass.

## Step 2 : Writing the recipe

Installing a package is easy, provided it's available through the distribution's package manager. Here's the recipe code that does exactly that, added to the recipe file we created earlier,`httpd.rb`.

```bash
package 'httpd'
```

## Step 3 : Running the unit tests

Now, let's run ChefSpec again, just as we did earlier on, and focus on the key part of the output.

```vim
nothingness::httpd
  converges successfully
  installs the Apache httpd package
  modifies its configuration file to our preference (PENDING: Not yet implemented)
  sets up the directory structure for the default website (PENDING: Not yet implemented)
  configures appropriate permissions for the default website directory structure (PENDING: Not yet implemented)
  configures the firewall to allow traffic for http and https ports (PENDING: Not yet implemented)
  enables and starts the httpd service (PENDING: Not yet implemented)
```

You can see that the expectation that was failing before now passes.

We now have another choice to make. We can either finish up with the remaining unit tests or we can move to the different stage in the QA chain. Again, for brevity, we'll choose the latter option in this document.

## Step 4 : Writing and running integration and functional tests

It's now time to move to functional tests. This part of the QA chain, along with integration tests, is handled by Test Kitchen and tested by writing tests in InSpec. Let's see how an InSpec functional test for the installation of the httpd package looks like. We'll place the following code in `test/integration/users/users_test.rb`.

```vim
# Has the httpd package been installed?
describe package('httpd') do
  it { should be_installed }
end
```

Contrary to ChefSpec that uses an `expect` syntax, InSpec uses a `should` syntax. It's a good idea have a comment state the expectation right before each test, but it's purely for readability.

Now, before we can run this test, we'll need to tell Test Kitchen what we want tested and how. Modify the `.kitchen.yml` file in the cookbook's top level directory as such

```vim
---
driver:
  name: vagrant

provisioner:
  name: chef_zero
  always_update_cookbooks: false

verifier:
  name: inspec

platforms:
  - name: centos-7.4
    driver:
      box: bento/centos-7.4

suites:
  - name: global
    run_list:
      - recipe[nothingness::httpd]
    verifier:
      inspec_tests:
        - test/integration/httpd
    attributes:
      host_context: ""
```

With this in place, we can now run our functional tests

```bash
cd ~/chef/cookbooks/nothingness
kitchen test
```

A Test Kitchen execution produces a lot of output, however what we're looking for is this

```bash
Profile: tests from {:path=>"/home/ctsag/chef/cookbooks/nothingness/test/integration/httpd"} (tests from {:path=>".home.ctsag.chef.cookbooks.nothingness.test.integration.httpd"})
Version: (not specified)
Target:  ssh://vagrant@127.0.0.1:2222

  System Package httpd
     ✔  should be installed

Test Summary: 1 successful, 0 failures, 0 skipped
```

With our functional test passedm it's now time to iterate with the rest of our tests. Remember, the primary approach is to write a test (or series of tests), watch it fail, then write just enough code to pass the failing tests. Then, start over until there are no more tests failing.

## Step 6 : Running lint tests

After your unit, functional and integration tests have validated your recipe, it's time to do some static code analysis, otherwise known as lint testing, or linting. This step is important as it enforces a uniform way of writing recipes, tests and Ruby in general, which in turn makes it easier for everyone working with Chef to read and understand what your code does. It also applies patterns that have been commonly accepted as best practices, which helps make your recipes more robust.

Now, for this step you don't have to write any tests yourself. Instead, the linting facilities Chef provides come with a series of rules out of the box. You can configure which of these rules you want applied but, for starters, let's accept the default ones.

Chef provides two linting tools, Cookstyle and Foodcritic. Cookstyle is a Rubocop based linting tool that is primarily concerned with syntax and so, to an extent, can be used to test all Ruby files within your project, not just your recipes or tests. Foodcritic, on the other hand, is concerned with recipes and the patterns used to write those recipes. Let's start with Cookstyle.

```bash
cd ~/chef/cookbook/nothingness
cookstyle .
```

This tests your entire cookbook. We won't get to possible output and how to resolve issues as it's a rather straightforward process.

Let's move to Foodcritic.

```bash
cd ~/chef/cookbooks/nothingness
foodcritic .
```

Again, we're not going to discuss about how to resolve Foodcritic suggestions here.

## Step 7 : Uploading the new version of the cookbook

Let's recap what we've done by the time we get to this point :

- we've broken the requirements of our task down and written them as distinct expectations, in plain English
- we've then defined which conditions fulfill our expectations
- we've run our tests and watch them fail
- we've then written recipe code that passes these tests
- we've applied our recipe on an ad-hoc virtual machine and written functional tests to verify it behaves as expected on a real environment, not just a simulation
- we've analyzed our code base against static analysis tools to make sure it conforms with known standards and best practices patterns

At this point, it's time to version our recipe and upload it to the Chef server, so that it can be distributed and applied to all registered nodes.

First, let's bump the version of our cookbook. Assuming we're currently at 0.1.0, we need to decide what kind of versioning bump represents our change. Chef uses a semantic versioning scheme, which splits the version in three parts, major, minor and revision. The major part of the version indicates a non backwards compatible change, the minor part indicates a backwards compatible feature addition and the revision is reserved for bug fixes. In this case, let's assume we've only added a backwards compatible feature. In this case, we need to get from 0.1.0 to 0.2.0 , and so we modify the `metadadata.rb` file in the top level directory of our cookbook accordingly.

Once we've done that, we can upload our cookbook to the Chef server. This document assumes we've been working with Berskhelf.

```bash
cd ~/chef/cookbooks/nothingness
berks upload --no-ssl-verify
```

## Step 8 : Updating bootstrapped nodes

With our fully tested new version of our recipe uploaded to the Chef server, it's time to apply it to our bootstrapped nodes.

But which nodes does this recipe apply to? This depends on how we're managing our nodes, i.e. how we inform Chef on what each nodes run list includes. It is heavily suggested that run lists are not assigned directly to the nodes themselves but, rather, to roles and enviornments. A node is then assigned a role and an environment and inherits their run list.

We'll asssume, therefore, that we've already set up a role named `webserver` and assigned it to some of our nodes. We'll need to add our recipe to our role's runlist. To do this, we'll need to edit our role file residing at `~/chef/cookbooks/nothingness/roles/webserver.json` and add the following line to the `run_list` element.

```vim
    "recipe[nothingness::httpd]"
```

Once that's done, we'll upload our updated role file to Chef server.

```bash
cd ~/chef/cookbooks/nothingness
knife role from file roles/webserver.json
```

We can now have our new recipe applied to all nodes that are registered with the `webserver` role.

```bash
cd ~/chef/cookbooks/nothingness
knife ssh 'role:webserver' 'chef-client' --ssh-user root
```

And that's about it. Our newly created, fully tested recipe has been applied to all relevant nodes.

## Step 9 (Optional) : Verifying nodes

As a bonus step, let's assume that months have passed and that you're wondering whether a specific node still complies to the Apache httpd recipe. How do we prove this is the case? And I mean definitely prove, down to the last detail of our configuration, not just glance over the node and make an estimated guess.

Well, good news. We can reuse the InSpec functional tests we wrote when we initially developed the recipe. And we can run those remotely, without the need to install any additional software. Let's assume we've identified the node's IP to be 192.168.1.60 . Standalone InSpec testing requires ssh-agent to run, so let's start that up and add our key.

```bash
eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
```

We can then execute our test on the remote host, like this.

```bash
cd ~/chef/cookbooks/nothingness
inspec exec test/integration/httpd/httpd_test.rb -t 'ssh://root@192.168.1.60'
```

The exact same tests that were run by Test Kitchen on an ad-hoc virtual machine when we were developing our recipe are now run on the actual node.

One option that is more suitable for standalone, ad-hoc InSpec manual tests than automated integration tests via Kitchen CI, is to execute an Inspec profile directly from Chef Supermarket, like this.

```bash
inspec supermarket exec dev-sec/nginx-baseline -t 'ssh://root@192.168.1.60'
```

This allows you to reuse existing tests suites and is an extremely powerful tool for compliance and security purposes.

## The full test suite

As promised, I'm including the full test suite for reference. But first, let's remember our expectations once more time. We expected to :

- install the Apache httpd package
- modify its configuration files to our preference
- set up the directory structure for the default website
- configure appropriate permissions for the default website directory structure
- configure the firewall to allow traffic for http and https ports
- enable and start the httpd service

And so, here are the unit tests for these expectations.

```ruby
require 'spec_helper'

describe 'nothingness::httpd' do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
    runner.converge(described_recipe)
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_call_original
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::default')
  end

  it 'includes the default recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('nothingness::default')
    chef_run
  end

  it 'installs the httpd package' do
    expect(chef_run).to install_package('httpd')
  end

  it 'puts the httpd configuration in place' do
    expect(chef_run).to create_cookbook_file('/etc/httpd/conf/httpd.conf').with(
      source: 'httpd.conf'
    )
  end

  it 'creates the httpd content directory structure' do
    directories = [
      '/srv/www',
      '/srv/www/default',
    ]

    directories.each do |dir|
      expect(chef_run).to create_directory(dir).with(
        owner: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end

  it 'opens up the http port' do
    expect(chef_run).to run_execute('firewall-cmd --add-port=80/tcp --permanent')
  end

  it 'opens up the https port' do
    expect(chef_run).to run_execute('firewall-cmd --add-port=443/tcp --permanent')
  end

  it 'enables and starts the httpd service' do
    expect(chef_run).to enable_service('httpd')
    expect(chef_run).to start_service('httpd')
  end
end
```

And here are the integration tests.

```ruby
# Has the httpd package been installed?
describe package('httpd') do
  it { should be_installed }
end

# Has the httpd content directory been put in place?
describe directory('/srv/www') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

# Has the content directory for the default site been put in place?
describe directory('/srv/www/default') do
  it { should exist }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0755' }
end

# Has the port for http been opened up?
describe port(80) do
  it { should be_listening }
end

# Has the port for https been opened up?
describe port(443) do
  it { should be_listening }
end

# Has the httpd service been enabled and is it running?
describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end
```

## Further reading

[Chef Webinar : Test-driven cookbook development](https://www.youtube.com/watch?v=qx2l4EELuGY)
