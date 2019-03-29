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

msg run this command to delete the cluster:
msg gcloud container clusters delete $CLUSTER --zone $ZONE
