var="$(ls /usr/local/bin/)"
brew="$(which brew)"

if [ "$brew" ]; then
    if [ "$var" ]; then
        echo "$var";
    else
        wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
        brew install argocd
    fi
else
    echo "Please install brew: https://brew.sh/";
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
fi

