# Minikube

You can have multiple minikube profiles by starting a cluster with the following command:

```shell
minikube start -p profile_name
```

You can then set that as the active profile for commands with:

```shell
minikube profile profile_name
```

And back to default with:

```shell
minikube profile default
```