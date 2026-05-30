We use K3S for creation of our cluster

K3S is a battery included k8s implementation. This implementation is chosen because it simplifies project complexity.

The only default k3s component that we will replace is to replace the CNI from Flannel into Cillium. Cillium is used because its eBPF based networking capability allows it to bypass iptables network stack, allowing for faster communication and allowing observability through using Hubble. eBPF based observability has advantage when compared to other common method of observability such as sidecar loading. Besides that CIllium provides a good support for multi cluster networking which supports the intended aim of this project for multi cloud kubernetes cluster. 