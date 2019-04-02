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

[ -n "$PROJECT" ] || die "missing env var PROJECT"
[ -n "$ZONE" ] || die "missing env var ZONE"
[ -n "$CLUSTER" ] || die "missing env var CLUSTER"

cat <<__EOF__
PROJECT=$PROJECT
ZONE=$ZONE
CLUSTER=$CLUSTER
__EOF__

# set default project
gcloud config set project $PROJECT

# enable APIs
gcloud services enable cloudapis.googleapis.com container.googleapis.com containerregistry.googleapis.com

# create cluster
gcloud container clusters create $CLUSTER \
	--zone=$ZONE \
	--cluster-version=latest \
	--machine-type=n1-standard-4 \
	--enable-autoscaling --min-nodes=1 --max-nodes=10 \
	--num-nodes=2 \
	--enable-autorepair \
	--scopes=service-control,service-management,compute-rw,storage-ro,cloud-platform,logging-write,monitoring-write,pubsub,datastore

# grant cluster-admin permissions to the current user
kubectl create clusterrolebinding cluster-admin-binding \
	--clusterrole=cluster-admin \
	--user=$(gcloud config get-value core/account)

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

