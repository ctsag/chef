# No-IP

No-IP offers a dynamic DNS service that allows you to create a host for 30 days. After this period the host gets deleted and needs to be created again, unless you go for a paid subscription. For a Chef managed infrastructure we'll need that No-IP service so create one, let's say nothingness.zapto.org

# DDNS router setup

The next step is to let your router know about your No-IP credentials and which host to send IP updates for. This is usually configured in the DDNS section of the router administration pages.

# Port forwarding

Add port forwarding for HTTPS (port 443), Chef (depends on configuration, 

# Linode DND record
