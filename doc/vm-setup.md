# Infrastructure Chain

All boxes are CentOS 7 based. The chain consists of an administration/server box, a development box, a QA box, a staging box and a production box. The first four are local VMs while the last one is a Linode VM.

In terms of local VMs, the administration box should be set at 4096MB RAM while all the rest should be set at 1024MB. 1 CPU and 10GB HDD will do.

In terms of the Linode VM, a Linode 1024 plan is good enough.

# VirtualBox VM Creation Wizard

## First Creen

Click on Expert Mode and fill in the following : Name should be something along the lines of "0. proudhon [Administration]". Type should be Linux and Version should be Red Hat (64-bit). Set memory as recommended above. Select "Create a Virtual hard disk now" and move to the next screen.

## Second Screen

Set a reasonable file name and make sure the file's destination is properly set. Set file size as recommended above and make sure the file type is dynamically allocated VDI. Click on create to complete the VM creation process.

## Post Creation Settings

After the VM has been created, go to its settings and make sure floppy and audio are both disabled, the CentOS 7 installation ISO image has been loaded to the CD-ROM device and that the network interface is set to Bridged Adapter.

# CentOS Installation Wizard

## Network And Host Name

Hostname should be set to something along the lines of "proudhon.int" (don't forget the int part). On the top left corner, switch the network on, then click on Configure. Go to the IPv4 tab, set the Method to Manual and add the IP, mask and gateway. Set the DNS servers to 1.1.1.1,1.0.0.1 and the search domain to something along the lines of "int.nothingness.gr" (again, don't forget the int part).

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
