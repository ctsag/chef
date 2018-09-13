# Additional QA facilities

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

```bash
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

## Functional and integration tests

TODO

## Manual node verification

TODO
