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

kubectl apply --filename service.yaml

APP_NAME=gowebhello

msg wait for an IP and URL:
msg
msg APP_NAME=$APP_NAME
msg
msg kubectl get svc istio-ingressgateway --namespace istio-system
msg kubectl get ksvc $APP_NAME 
msg
msg then hit ENTER to continue

read i

msg IP Address:
kubectl get svc istio-ingressgateway --namespace istio-system
msg URL:
kubectl get ksvc $APP_NAME --output=custom-columns=NAME:.metadata.name,DOMAIN:.status.domain
kubectl get ksvc $APP_NAME

IP_ADDRESS=$(kubectl get svc istio-ingressgateway --namespace istio-system --output 'jsonpath={.status.loadBalancer.ingress[0].ip}')
HOST_URL=$(kubectl get ksvc $APP_NAME --output jsonpath='{.status.domain}')

msg address: $IP_ADDRESS
msg URL:     $HOST_URL

msg curl -H \"Host: $HOST_URL\" http://${IP_ADDRESS}
