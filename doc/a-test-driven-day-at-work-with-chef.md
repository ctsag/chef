# A test driven day at work with Chef

## Introduction

The purpose of this document is to describe a test driven workflow into writing a new recipe. It's assumed that a basic Chef insfrastructure is in place, that a cookbook has been created, that run lists have been assigned and that Test Kitchen and its dependencies (e.g. Vagrant and VirtualBox) have been configured and tested to work end to end.

We're also not going to deal with the semantics of specific Chef components such as ChefSpec, Kitchen, etc. Knowledge of how each component works and how to write code for it is heavily assumed.

So, let's figure out how to install and configure the Apache httpd server, using a test driven approach.

## Step 1 : Writing the unit tests

ChefSpec, Chef's rendition of RSpec, is used for unit testing. Unit tests are stored in the spec/unit/recipes directory, in files named ${recipe}_spec.rb . Each file holds the entire suit of tests for a single recipe. Here's a skeleton test suite that simply tests whether the recipe successfully converges

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

Before we go any further, notice how ChefSpec::ServerRunner is instantiated. It's being told that the platform is CentOS 7.4.1708. You can use ChefSpec contexts to create test suites for the same recipe for different platforms. Apache httpd, for example, might need to be configured differently on Ubuntu. Keep this in mind, because we're not going to deal with multi platform testing in the document.

Now, ChefSpec uses the expect syntax of RSpec to declare expectations. With the boiler plate code above at hand we can now start adding what we expect our recipe to do. At this stage, we don't need to implement how these expectations are tested, just what we expect, in plain English. So, what do we expect an httpd recipe to do? We expect it to

- install the Apache httpd package
- modify its configuration files to our preference
- set up the directory structure for the default website
- configure appropriate permissions for the default website directory structure
- configure the firewall to allow traffic for http and https ports
- enable and start the httpd service

So, here are these expectations added into the test suite

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

This simple step of declaring expectation is key to why a test driven approach is a great way to work. By declaring our expectations we essentially break down and document the requirements of the task. We've taken a vague requirement such as "install a web server", broken it down into distinct steps and documented those steps clearly and concisely.

The next step is take the first unimplemented expectation and write down what conditions would prove that it has been fulfilled. Let's do that now for "installs the apache httpd package". What do we expect? We expect Chef to install a package named httpd.

```ruby
it 'installs the Apache httpd package' do
  expect(chef_run).to install_package('httpd')
end
```

And it's as simple as that, almost plain English. At this point, we have two options. We can write the test implentations for our remaining expectations, or we can iterate the recipe that fulfills this first expectation

## Step 2 : Writing the recipe

TODO

## Step 3 : Running the unit tests

TODO

## Step 4 : Writing integration and functional tests

TODO

## Step 6 : Running lint tests

TODO

## Step 7 : Uploading the new version of the cookbook

TODO

## Step 8 : Updating nodes

TODO

## Step 9 (Optional) : Verifying nodes

TODO
