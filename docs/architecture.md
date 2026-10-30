# Architecture

```mermaid
flowchart LR
  subgraph RAN["ran-sim (192.168.100.20)"]
    UE["UE UERANSIM"]
    gNB["gNB UERANSIM"]
    iperf["iperf3"]
  end
  subgraph CP["k8s-cp (.10)"]
    etcd["etcd, API server, scheduler"]
  end
  subgraph W1["k8s-w1 (.11)"]
    core["AMF, SMF, UPF, NRF, UDM, MongoDB"]
  end
  subgraph W2["k8s-w2 (.12)"]
    mon["Prometheus, Grafana, Alertmanager"]
  end
  UE --> gNB
  gNB -- "N2 NGAP/SCTP vers .200" --> core
  gNB -- "N3 GTP-U vers .201" --> core
  core -. "métriques" .-> mon
  CP --- W1
  CP --- W2
```

## Plan d'adressage

| Élément | Valeur |
|---------|--------|
| Réseau VM (VMnet8, NAT) | 192.168.100.0/24, passerelle .2 |
| k8s-cp / k8s-w1 / k8s-w2 / ran-sim / wazuh | .10 / .11 / .12 / .20 / .30 |
| Pod CIDR (Calico) | 10.244.0.0/16 |
| Service CIDR | 10.96.0.0/12 |
| Pool MetalLB (L2) | 192.168.100.200-210 (AMF .200, UPF .201) |

## Dimensionnement

| VM | vCPU | RAM | Disque |
|----|------|-----|--------|
| k8s-cp | 2 | 3 Go | 25 Go |
| k8s-w1 | 3 | 6 Go | 35 Go |
| k8s-w2 | 3 | 6 Go | 40 Go |
| ran-sim | 2 | 2 Go | 15 Go |
| wazuh (phase 2) | 4 | 8 Go | 40 Go |
