#!/bin/bash
#
# Procedure from:
#
# https://github.com/meteatamel/knative-tutorial/blob/master/docs/02-configuredomain.md

me=$(basename "$0")
msg() {
    echo >&2 "$me:" "$@"
}

die() {
	msg "$@"
	exit 1
}

APP_NAME=gowebhello

msg APP_NAME=$APP_NAME

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
