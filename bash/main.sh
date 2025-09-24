#!/bin/bash

# renovate: datasource=github-releases depName=helm/helm
HELM_VERSION="v3.17.3"

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh --no-sudo --version "$HELM_VERSION"
