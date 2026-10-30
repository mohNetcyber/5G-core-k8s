# Réseau VMware

- VMnet8 (NAT) : `192.168.100.0/24`, passerelle `192.168.100.2`
- Désactiver le DHCP VMware pour les VMs ou réserver les IP `.10 .11 .12 .20 .30`
- Pool MetalLB `.200-.210` : hors plage DHCP
- Snapshot VMware à chaque jalon
