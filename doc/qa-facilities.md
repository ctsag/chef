# QA facilities

## Lint testing

Chef provides two methods of static code analysis (or linting, if you prefer). The first, Cookstyle is focused towards Ruby code analysis while the second, Foodcritic is more specific to Chef code.

### Cookstyle

To inspect all Ruby files within the current working directory recursively, just run

```bash
cd ~/chef/cookbook/nothingness
cookstyle .
```

To insepect a single file

```bash
cd ~/chef/cookbook/nothingness
cookstyle recipes/default.rb
```

Cookstyle is based on Rubocop and, as such, you can control a lot of aspects of its behaviour by placing a file named .rubocop.yml in the cookbook directory. For example, to modify what constitutes an acceptable line terminator (useful for Windows), you can add the following :

```yml
Layout/EndOfLine:
  EnforcedStyle: native
```

### Foodcritic

Foodcritic is used to inspect recipe, role and environment files so don't expect it to check every Ruby file in the path you provide. To inspect all applicable files within a cookbook

```bash
cd ~/chef/cookbooks/nothingness
foodcritic .
```

## Unit testing

For unit testing, Chef offers ChefSpec, an RSpec and ServerSpec inspired facility that attempts to simulate a cookbook execution in memory. Contrary to InSpec, which uses a "should" based syntax, ChefSpec is traditionally written in "expect" syntax.

ChefSpec unit tests are usually stored in ./spec/unit/recipes and can be executed like this

```bash
cd ~/chef/cookbooks/nothingness
chef exec rspec
```

You can (and should) write unit tests for each platform context your recipes are intended to run on, e.g. one for CentOS, one for Ubuntu, etc.

It's also important to remember that, like any solid unit test engine, ChefSpec provides coverage reports at the end of each execution and can even tell you which resources were not touched. The coverage rport looks something like this

```bash
ChefSpec Coverage report generated...

  Total Resources:   72
  Touched Resources: 69
  Touch Coverage:    95.83%

Untouched Resources:

  yum_package[kernel-devel-3.10.0-693.el7.x86_64]   nothingness/recipes/virtualbox:11
  yum_package[gcc]                   nothingness/recipes/virtualbox.rb:11
  yum_package[virtualbox-5.2]        nothingness/recipes/virtualbox.rb:11
```

Last but not least, you can permanently configure ChefSpec's behaviour by placing an .rspec file at the top level directory of your cookbook. You can have this done automatically by running

```bash
cd ~/chef/cookbooks/nothingness
chef exec rspec --init
```

This will place the .rspec file at the present working directory. Initially, the file will look like this

```bash
--require spec_helper
```

You can add any arguments you want to this. For example, to add color and use the InSpec-like documentation format (instead of the progress format), you can have your .rspec file look like this

```bash
--require spec_helper
--color
--format d
```

## Functional and integration tests

Functional and integration tests are handled by Kitchen CI, more commonly referred to as Test Kitchen or just Kitchen.

Kitchen tests are traditionally written in InSpec, Chef's transmutation of RSpec/ServerSpec. These are then executed on Vagrant managed ad-hoc instances.

Working with Kitchen is further documented on the following document

[Working with Test Kitchen](/doc/working-with-test-kitchen.md)

## Manual node verification

Although Test Kitchen runs on InSpec tests, InSpec itself is not limited within the context of Test Kitchen, or even Chef. Instead, it can used as a standalone way to manually execute tests, both locally and on remote hosts.

What's great about this way of working with InSpec is that you can run a test on a remote host without having to install anything on it.

Again, working with InSpec in a standalone context is documented on the following document

[Working with Test Kitchen](/doc/working-with-test-kitchen.md)
