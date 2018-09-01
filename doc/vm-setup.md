# Infrastructure Chain

All boxes are CentOS 7 based. The chain consists of an administration/server box, a development box, a QA box, a staging box and a production box. The first four are local VMs while the last one is a Linode VM.

In terms of local VMs, the administration box should be set at 4096MB RAM while all the rest should be set at 1024MB. 1 CPU and 20GB HDD will do.

In terms of the Linode VM, a Linode 1024 plan is good enough.

# VMWare Creation Wizard

## Warning

VMWare orders the list of VMs in a weird way, in that the last VM created gets to be the first in the list. Take that into account when creating multiple VMs.

## First Creen

Select "Installer disc image file (iso)" and browser to the CentOS 7 ISO file.

## Second Screen

Set virtual machine name to something alone the lines of "0. proudhon [Administration]" and location to something along the lines of "D:\Virtualization\proudhon"

## Third Screen

Set disk size to 20GB and select "Store virtual disk as a single file"

## Fourth Screen

Clic on "Customize Hardware" and make sure tha memory and CPU are set as recommended above. Make sure audio is disabled and set the network adapter to Bridged. On the network adapter tab, click on "Configure Adapters" and deselect everything but the actual physical adapter. On the USB Controller tab, deselect all options.

# CentOS Installation Wizard

## Network And Host Name

Hostname should be set to something along the lines of "proudhon". On the top left corner, switch the network on, then click on Configure. Go to the IPv4 tab, set the Method to Manual and add the IP, mask and gateway. Set the DNS servers to 1.1.1.1,1.0.0.1 and the search domain to something along the lines of "int.nothingness.gr" (don't forget the int part).

## Installation Destination

Just enter the screen and press Done.

## Date & Time

Set region and city as appropriate and switch network time on.

## Keyboard Layout

Add any required languages, for example "Greek, Modern (1453-) (Greek)", click on Options and select Alt+Shift as the switch layout keyboard shortcut.

## KDump

Disable KDump

## Security Policy

Switch off security policy.
