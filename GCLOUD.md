# Setup

Based on the steps [here](https://cloud.google.com/kubernetes-engine/docs/deploy-app-cluster).

1. Sign in

 ```shell
gcloud auth login
gcloud config set project PROJECT_ID
```

2. Create the cluster

```shell
 gcloud config set project PROJECT_ID
 gcloud container clusters create-auto CLUSTER_NAME --region=europe-west4
 gcloud container clusters get-credentials CLUSTER_NAME --region europe-west4
 ```

3. Set up static ip

```shell
gcloud compute addresses create web-ip --global
gcloud compute addresses list
gcloud compute addresses describe web-ip --format='value(address)' --global
  ```

```shell
# Domain name via transip.nl
export IP_ADDRESS=34.102.255.52
export DOMAIN_NAME=oibss.nl
export CLUSTER_NAME=rekeningrijden
```

4. Cert manager

```shell
kubectl apply -f google/ingress.yml
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
```
```shell
kubectl apply -f google/cert-letsencrypt-staging.yml
```
```shell
helm upgrade --install --wait --timeout 15m --atomic --namespace keycloak --create-namespace     --repo https://charts.bitnami.com/bitnami keycloak keycloak --reuse-values -f extracted/keycloak-values.yml
```

# Internal DNS names

keycloak.keycloak.svc.cluster.local (port 80)

# Stuff

Helm including scripts: https://medium.com/google-cloud/installing-helm-in-google-kubernetes-engine-7f07f43c536e
Cert
manager: https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/
Google managed certs: https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs