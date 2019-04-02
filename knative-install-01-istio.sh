#!/bin/bash
#
# Procedure from:
#
# https://www.knative.dev/docs/install/knative-with-gke/

me=$(basename "$0")
msg() {
    echo >&2 "$me:" "$@"
}

die() {
	msg "$@"
	exit 1
}

# install istio
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/istio-crds.yaml
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.4.0/istio.yaml 

# label the default namespace with istio-injection=enabled
kubectl label namespace default istio-injection=enabled

msg
msg monitor the Istio components until all of the components show a STATUS of Running or Completed:
msg
msg kubectl get pods --namespace istio-system --watch
msg 
msg then hit ENTER to continue

read i

