1. Run
    ```shell
    mv repo-empty.yaml repo.yaml
    ```
2. Set user and password in repo.yaml
3. Apply the repo.yaml with the before trying to add other argocd apps
    ```shell
    kubectl apply repo.yaml
    ```
4. 