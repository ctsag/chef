name 'nothingness'
maintainer 'Christos Tsagkournis'
maintainer_email 'chrtsago@yahoo.gr'
license 'GPL-3.0'
description 'Installs/Configures chef'
version '0.15.0'

issues_url 'https://github.com/ctsag/chef/issues'
source_url 'https://github.com/ctsag/chef'

supports 'centos'

chef_version '>= 12.1' if respond_to?(:chef_version)
