# Setup

Based on the steps [here](https://cloud.google.com/kubernetes-engine/docs/deploy-app-cluster).

```shell
# Domain name via transip.nl
export IP_ADDRESS=34.102.255.52
export DOMAIN_NAME=oibss.nl
export CLUSTER_NAME=rekeningrijden
export PROJECT_ID=rekeningrijden-fontys
```

1. Sign in

 ```shell
gcloud auth login
gcloud config set project $PROJECT_ID
```

2. Create the cluster

```shell
gcloud config set project $PROJECT_ID
gcloud container clusters create-auto $CLUSTER_NAME --region=europe-west4
gcloud container clusters get-credentials $CLUSTER_NAME --region europe-west4
 ```

3. Set up static ip

```shell
gcloud compute addresses create web-ip --global
gcloud compute addresses list
gcloud compute addresses describe web-ip --format='value(address)' --global
  ```

4. Cert manager

```shell
#kubectl apply -f google/ingress.yml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install --wait --timeout 10m --atomic --create-namespace --namespace cert-manager --set global.leaderElection.namespace=cert-manager cert-manager jetstack/cert-manager --reuse-values -f extracted/cert-manager-values.yml
```
```shell
kubectl apply -f google/cert-letsencrypt-staging.yml
```
```shell
helm upgrade --install --wait --timeout 10m --atomic --namespace keycloak --create-namespace --repo https://charts.bitnami.com/bitnami keycloak keycloak -f google/keycloak-values.yml
```
```shell
kubectl apply -f google/empty-secret.yml
```
```shell
export TF_STATE=.tf-state/keycloak.tfstate
terraform -chdir=./google/terraform/keycloak init && terraform -chdir=./google/terraform/keycloak apply -auto-approve -state=$TF_STATE
```


# Internal DNS names

keycloak.keycloak.svc.cluster.local (port 80)

# Stuff

Helm including scripts: https://medium.com/google-cloud/installing-helm-in-google-kubernetes-engine-7f07f43c536e
Cert
manager: https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/
Google managed certs: https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs