name="iot-gchopin";
if [ -z "$1" ]; then
    echo "--create Create a new k3s cluster with containerized nodes (k3s in docker).";
    echo "--delete Delete cluster";
    echo "--start Start existing k3d cluster";
    echo "--stop Stop existing k3d cluster";
    echo "--list List clusters";
fi

if [ "$1" ]; then
    case "$1" in
        "--create") k3d cluster create --config ./confs/k3d.yaml
        kubectl create namespace argocd
        kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v3.0.3/manifests/install.yaml
        kubectl apply -f confs/ingress.yaml
        kubectl apply -f confs/argocd-cmd-param-cm.yaml
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