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


