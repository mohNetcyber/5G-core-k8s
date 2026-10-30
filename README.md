# Cœur 5G SA cloud-native sur Kubernetes (Open5GS + UERANSIM)

Déploiement, supervision et mesure de résilience d'un cœur 5G SA sur un cluster
Kubernetes (kubeadm) hébergé sur VMware Workstation Pro.

**Auteur** : Mohamed TRAORE, ENSA Fès (SCSN 3e année) · **Statut** : brouillon v0.1

## Architecture

| VM         | Rôle                         | IP               |
|------------|------------------------------|------------------|
| `k8s-cp`   | Control plane                | 192.168.100.10   |
| `k8s-w1`   | Cœur 5G (Open5GS)            | 192.168.100.11   |
| `k8s-w2`   | Monitoring                   | 192.168.100.12   |
| `ran-sim`  | UERANSIM + iperf3            | 192.168.100.20   |
| `wazuh`    | Wazuh (optionnel, phase 2)   | 192.168.100.30   |

- Réseau VMnet8 (NAT) `192.168.100.0/24`
- Pod CIDR `10.244.0.0/16`, Service CIDR `10.96.0.0/12`
- MetalLB L2 : `192.168.100.200-210` (AMF `.200` SCTP, UPF `.201` GTP-U)

Détails : [docs/architecture.md](docs/architecture.md) · Versions : [docs/versions.md](docs/versions.md)

## Démarrage rapide

```bash
# 1. Sur chaque VM K8s : préparation OS + containerd + kubeadm
sudo bash infra/common/01-os-prep.sh
sudo bash infra/common/02-containerd.sh
sudo bash infra/common/03-kubeadm-install.sh

# 2. Sur k8s-cp
sudo bash infra/control-plane/init.sh
# puis sur les workers : copier infra/workers/join.sh.example en join.sh (ignoré par Git)

# 3. Add-ons, supervision, cœur 5G (depuis k8s-cp)
make addons
make monitoring
make core

# 4. Sur ran-sim
make ran-help

# 5. Tests
make test
```

## Structure

| Dossier       | Contenu                                               |
|---------------|-------------------------------------------------------|
| `docs/`       | CDC, architecture, versions, journal, rapport         |
| `infra/`      | Scripts VM/kubeadm, add-ons (Calico, MetalLB, stockage)|
| `monitoring/` | kube-prometheus-stack, alertes, dashboards Grafana    |
| `core/`       | Open5GS : values Helm, services SCTP/GTP-U, abonnés   |
| `ran/`        | Configs UERANSIM (gNB, UE)                            |
| `tests/`      | Scripts T1 à T9 + utilitaires de statistiques         |
| `results/`    | Données brutes, agrégats, figures                     |
| `security/`   | Wazuh (optionnel)                                     |
| `scripts/`    | Déploiement complet / teardown                        |

## Avancement des jalons

- [ ] J1 : cluster `Ready` (sem. 2)
- [ ] J2 : Grafana accessible (sem. 3)
- [ ] J3 : ping via UPF (sem. 5)
- [ ] J4 : supervision complète (sem. 6)
- [ ] J5 : redéploiement scripté (sem. 8)
- [ ] Livraison (sem. 10)

## Conventions

- Versions **épinglées** dans [docs/versions.md](docs/versions.md)
- Aucun secret dans Git (voir `.gitignore`)
- Un tag Git + un snapshot VMware à chaque jalon (`jN-<nom>`)
