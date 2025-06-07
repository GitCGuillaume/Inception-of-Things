name="iot-gchopin"
if [ -z "$1" ]; then
    echo "--create Create a new k3s cluster with containerized nodes (k3s in docker).";
    echo "--delete Delete cluster";
    echo "--start Start existing k3d cluster";
    echo "--stop Stop existing k3d cluster";
    echo "--list List clusters";
fi

if [ "$1" ]; then
    case "$1" in
        "--create")
        if [ -f .env ]; then
            k3d cluster create --config ./confs/k3d.yaml
            source .env
            kubectl apply -f confs/argocd_ns.yaml
            kubectl apply -f confs/dev_ns.yaml
            kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v3.0.3/manifests/install.yaml
            kubectl apply -f confs/ingress.yaml
            kubectl apply -f app/app-ingress.yaml
            kubectl apply -f confs/argocd-cmd-param-cm.yaml
            echo "Waiting for argocd pods: kubectl -n argocd wait --for=condition=ready pod --all --timeout=600s"
            kubectl -n argocd wait --for=condition=ready pod --all --timeout=600s
            TMP_PSW=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
            argocd login kubernetes.docker.internal:8080 --grpc-web --username admin --password $TMP_PSW --insecure
            argocd account update-password --grpc-web --new-password $PSW_ADM --current-password $TMP_PSW
            argocd repo add https://github.com/GitCGuillaume/Inception-of-Things.git
            kubectl apply -f app/application.yaml
        else
            echo "Please add a .env file with PSW_ADM=(8..32 characters).";
        fi
        ;;
        "--delete") k3d cluster delete $name
        ;;
        "--start") k3d cluster start $name
        ;;
        "--stop") k3d cluster stop $name
        ;;
        "--list") k3d cluster list
        ;;
    esac
fi