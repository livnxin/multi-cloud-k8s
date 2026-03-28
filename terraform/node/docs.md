# Documentation

This module is for the vm instances that will be needed to run the k3s instances

I intentionally do not want to assocaite any public IP address to my nodes because I believe that associating public address with each vm instances will only expose unnecessary risk to the vm. As nodes of the k3s kubernetes cluster, these nodes should only be exposed to the outside world through load balanced ingress controller and preferably with strict firewall such as AWS Security Group for example