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

kubectl delete --filename service.yaml

