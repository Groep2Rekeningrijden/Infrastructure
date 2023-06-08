#!/usr/bin/env bash

set -e

readonly IP_ADDRESS=34.102.255.52
readonly DOMAIN_NAME=oibss.nl
readonly CLUSTER=rekeningrijden

log() {
  echo "---------------------------------------------------------------------------------------"
  echo $1
  echo "---------------------------------------------------------------------------------------"
}

wait_ready() {
  local NAME=${1:-pods}
  local TIMEOUT=${2:-5m}
  local SELECTOR=${3:---all}

  log "WAIT $NAME ($TIMEOUT) ..."

  kubectl wait -A --timeout=$TIMEOUT --for=condition=ready $NAME $SELECTOR
}

wait_pods_ready() {
  local TIMEOUT=${1:-5m}

  wait_ready pods $TIMEOUT --field-selector=status.phase!=Succeeded
}

wait_nodes_ready() {
  local TIMEOUT=${1:-5m}

  wait_ready nodes $TIMEOUT
}

cilium() {
  log "CILIUM ..."

  helm upgrade --install --wait --timeout 15m --atomic --namespace kube-system --create-namespace \
    --repo https://helm.cilium.io cilium cilium -f /extracted/cilium-values.yml
}

cert_manager() {
  log "CERT MANAGER ..."

  helm upgrade --install --wait --timeout 15m --atomic --namespace cert-manager --create-namespace \
    --repo https://charts.jetstack.io cert-manager cert-manager -f /extracted/cert-manager-values.yml
}