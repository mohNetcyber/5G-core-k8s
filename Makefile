.PHONY: addons monitoring core ran-help test lint teardown help

KUBECTL ?= kubectl
HELM    ?= helm

help:
	@echo "Cibles : addons | monitoring | core | ran-help | test | lint | teardown"

addons:
	$(KUBECTL) apply -f infra/addons/calico/custom-resources.yaml
	$(KUBECTL) apply -f infra/addons/metallb/ipaddresspool.yaml
	$(KUBECTL) apply -f infra/addons/metallb/l2advertisement.yaml
	@echo "TODO : installer Tigera operator, MetalLB et local-path-provisioner (voir infra/addons/*/README.md)"

monitoring:
	$(HELM) upgrade --install kps prometheus-community/kube-prometheus-stack \
	    -n monitoring --create-namespace \
	    -f monitoring/kube-prometheus-stack/values.yaml
	$(KUBECTL) apply -f monitoring/alerts/

core:
	$(KUBECTL) apply -f core/namespace.yaml
	$(KUBECTL) apply -f core/manifests/mongodb-pvc.yaml
	@echo "TODO : helm upgrade --install open5gs <chart> -n open5gs -f core/helm/values-base.yaml"
	$(KUBECTL) apply -f core/manifests/amf-svc-sctp.yaml
	$(KUBECTL) apply -f core/manifests/upf-svc-gtpu.yaml

ran-help:
	@echo "Sur ran-sim : bash ran/run-gnb.sh puis bash ran/run-ue.sh"

test:
	bash tests/run-all.sh

lint:
	yamllint -d relaxed . || true
	shellcheck $$(find . -name '*.sh')

teardown:
	bash scripts/teardown.sh
