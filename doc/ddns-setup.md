# No-IP

No-IP offers a dynamic DNS service that allows you to create a host for 30 days. After this period the host gets deleted and needs to be created again, unless you go for a paid subscription. For a Chef managed infrastructure we'll need that No-IP service so create one, let's say nothingness.zapto.org

# DDNS router setup

The next step is to let your router know about your No-IP credentials and which host to send IP updates for. This is usually configured in the DDNS section of the router administration pages.

# Port forwarding

Add port forwarding for SSH (port 22), HTTP (port 80), HTTPS (port 443) and Chef (/etc/opscode/chef-server.rb on the Chef admin box contains the ports, for instance 4443-4444) and send them all to the administration box.

# Linode DND record

In Linode's DNS manager, make sure to add a CNAME to your DDNS host for your administration box.
