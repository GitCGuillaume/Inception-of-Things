brew="$(which brew)"
kube="$(which kubectl)"
k3d="$(which k3d)"
argo="$(which argocd)"

if [ "$brew" ]; then
    if [ ! "$k3d" ]; then
        wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
    else
        echo "K3d is already installed.";
    fi
    if [ ! "$argo" ]; then
        brew install argocd
    else
        echo "ArgoCD is already installed.";
    fi
    if [ ! "$kube" ]; then
        brew install kubectl
    else
        echo "Kubectl is already installed.";
    fi
else
    echo "Please install brew: https://brew.sh/";
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
fi

