# What is this?

The purpose of this project is to propose and implement a minimal development pipeline managed by Chef. It is, effectively, the documentation of of the author's living experiments with Chef, DevOps, and concepts such as Constinuous Integration, Continuous Delivery and Continuous Automation.

Throughout the experiment, emphasis has been placed into implementing a test driven approach to as much as the development process as possible. It is the author's firm belief that, just as there is no science without the principle of falsifiability, so there is no computer science without the equivalent of falsifiability, which is using tests to prove (or disprove) that what we build works.

## Proposed infrastructure

The infrastrucure proposed consists of the following

- a Chef server
- a Chef management workstation
- a QA box
- a staging box
- a production box

This infrastructure is bare bones but the plan is to progressively add optional or missing pieces to it. For instance, one could easily add dedicated database and/or indexing servers, network storage, LDAP, and even multiple application server boxes, depending on the nature of the project being worked on.

For the time being, it is preferable to keep the proposed infrastructure bare bones and allow anyone who uses this project to expand the infrastructure provided.

## Conventions

A number of conventions within the project that are currently hardcoded into the code provided. To make things a bit easier to modify, efforts have been made to keep anything that is hardcoded in this way to a single place, so that there is no need to change values in multiple places. Until hardcoding is removed, however, it might be useful to list these conventions :

- a sudo user is created for each environment. This user's login ('ctsag'), password, email address ('chrtsago@yahoo.gr') and full name ('Christos Tsagkournis') are all coded into the project and should be modified to suit the user
- the hostnames for each environment are set as such : proudhon is the Chef server, decleyre is the Chef workstation, bakunin is the QA box, kropotkin is the staging  box and goldman is the production box.
- the domain name is set to nothingness.gr and its internal subdomain is set to int.nothingness.gr
- in various prompts to type in shell commands, it is assumed that you have cloned this project to ~/chef and that your cookbook is named 'nothingness', meaning your full cookbook path will be '~/chef/cookbooks/nothingness'

## Documentation

Now that we're done with the introductions, here's a compilation of documents to get you up to speed with the workflow used in this paradigm

[DDNS setup](/doc/ddns-setup.md)

[VM setup](/doc/vm-setup.md)

[Setting up a Chef Server](/doc/chef-server-setup.md)

[Setting up a Chef Workstation](/doc/chef-workstation-setup.md)

[Basic Chef operations](/doc/basic-chef-operations.md)

[QA facilities](/doc/qa-facilities.md)

[Working with Test Kitchen](/doc/working-with-test-kitchen.md)

[A test driven day at work with Chef](/doc/a-test-driven-day-at-work-with-chef.md)
