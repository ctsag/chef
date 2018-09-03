# Infrastructure Chain

All boxes are CentOS 7 based. The chain consists of an administration/server box, a development box, a QA box, a staging box and a production box. The first four are local VMs while the last one is a Linode VM.

In terms of local VMs, the administration and development boxes should be set at 3072MB RAM while all the rest should be set at 1024MB. 1 CPU and 20GB HDD will do.

In terms of the Linode VM, a Linode 1024 plan is good enough.

# Hyper-V Creation Wizard

## Installing Hyper-V

Hyper-V is an optional component of Microsoft Windows, so all you have to do to install it is to select it from the list of of optional Windows features in the Add/Remove Programs section of Control Panel.

## Virtual Switch

To enable networking, you'll need to create a virtual network switch. This can be done in the Virtual Switch Manager section of the Hyper-V Manager. Make sure it's named appropriately and set to External Network and bridge it to your network adapter. Also, remember to tick the "Allow management operating system to share this network adapter" box.

## Creation Wizard - First Screen

Just press next.

## Creation Wizard - Second Screen

Naming should be along the lines of "0. proudhon [Administration]", "1. decleyre [Development]" and so on and so forth. Tick the "Store the virtual machine in a different location" box and specify an appropriate path.

## Creation Wizard - Third Screen

Select Generation 2.

## Creation Wizard - Fourth Screen

Make sure "Use Dynamic Memory for this virtual machine" is ticked and select the appropriate RAM size.

## Creation Wizard - Fifth Screen

Here's where you specify the virtual network switch we discuseed earlier on.

## Creation Wizard - Sixth Screen

Just specify the size of the virtual hard disk here.

## Creation Wizard - Seventh Screen

Make sure you specify the location of the CentOS 7 installer ISO image.

## Creation Wizard - Eigth Screen

Just press Finish.

## Post Creation Wizard Configuration

On the VM's Settings dialogue, go to the Security section and untick the "Enable Secure Boot" box. On the Integration Services section, enable everything.

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
