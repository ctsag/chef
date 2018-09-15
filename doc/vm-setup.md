# VM setup

## Infrastructure chain

All boxes are CentOS 7 based. The chain consists of an administration/server box, a development box, a QA box, a staging box and a production box. The first four are local VMs while the last one is a Linode VM.

In terms of local VMs, the administration box should be set at 4096MB RAM, the development box should be set at 2048MB RAM while all the rest should be set at 1024MB. 1 CPU and 20GB HDD will do.

In terms of the Linode VM, a Linode 1024 plan is good enough.

## Hyper-V creation wizard

### Installing Hyper-V

Hyper-V is an optional component of Microsoft Windows, so all you have to do to install it is to select it from the list of of optional Windows features in the Add/Remove Programs section of Control Panel.

### Virtual switch

To enable networking, you'll need to create a virtual network switch. This can be done in the Virtual Switch Manager section of the Hyper-V Manager. Make sure it's named appropriately and set to External Network and bridge it to your network adapter. Also, remember to tick the "Allow management operating system to share this network adapter" box.

### Creation wizard : Screen 1

Just press next.

### Creation wizard : Screen 2

Naming should be along the lines of "0. proudhon [Administration]", "1. decleyre [Development]" and so on and so forth. Tick the "Store the virtual machine in a different location" box and specify an appropriate path.

### Creation wizard : Screen 3

Select Generation 2.

### Creation wizard : Screen 4

Make sure "Use Dynamic Memory for this virtual machine" is ticked and select the appropriate RAM size.

### Creation wizard : Screen 5

Here's where you specify the virtual network switch we discuseed earlier on.

### Creation wizard : Screen 6

Just specify the size of the virtual hard disk here.

### Creation wizard : Screen 7

Make sure you specify the location of the CentOS 7 installer ISO image.

### Creation wizard : Screen 8

Just press Finish.

### Post creation wizard configuration

On the VM's Settings dialogue, go to the Security section and untick the "Enable Secure Boot" box. On the Integration Services section, enable everything.

### Enabling nested virtualization

Enabling nested virtualization for Hyper-V can be done via a small script included in this repo. You'll need to have the boxes shut down when you run this and the PowerShell console needs to be launched as an administrator. This step is required in the administration and development boxes only, as they're the ones that are tasked with running VirtualBox.

```pwsh
.\Enable-NestedVm.ps1 -VmName '*proudhon*'
```

## CentOS installation wizard

### Network and host name

Hostname should be set to something along the lines of "proudhon". On the top left corner, switch the network on, then click on Configure. Go to the IPv4 tab, set the Method to Manual and add the IP, mask and gateway. Set the DNS servers to 1.1.1.1,1.0.0.1 and the search domain to something along the lines of "int.nothingness.gr" (don't forget the int part).

### Installation Destination

Just enter the screen and press Done.

### Date and time

Set region and city as appropriate and switch network time on.

### Keyboard layout

Add any required languages, for example "Greek, Modern (1453-) (Greek)", click on Options and select Alt+Shift as the switch layout keyboard shortcut.

### KDump

Disable KDump

### Security policy

Switch off security policy.
