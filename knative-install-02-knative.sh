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

# install Knative and its dependencies

knative_once() {
kubectl apply \
	--filename https://github.com/knative/serving/releases/download/v0.4.0/serving.yaml \
	--filename https://github.com/knative/build/releases/download/v0.4.0/build.yaml \
	--filename https://github.com/knative/eventing/releases/download/v0.4.0/release.yaml \
	--filename https://github.com/knative/eventing-sources/releases/download/v0.4.0/release.yaml \
	--filename https://github.com/knative/serving/releases/download/v0.4.0/monitoring.yaml \
	--filename https://raw.githubusercontent.com/knative/serving/v0.4.0/third_party/config/build/clusterrole.yaml
}

knative_once ;# first try on 0.4 may fail
knative_once ;# then try again

msg Monitor the Knative components until all of the components show a STATUS of Running:
msg
msg kubectl get pods --namespace knative-serving
msg kubectl get pods --namespace knative-build
msg kubectl get pods --namespace knative-eventing
msg kubectl get pods --namespace knative-sources
msg kubectl get pods --namespace knative-monitoring

