#!/bin/bash
#
# Procedure from:
#
# https://github.com/meteatamel/knative-tutorial/blob/master/docs/01-helloworldserving.md

me=$(basename "$0")
msg() {
    echo >&2 "$me:" "$@"
}

die() {
	msg "$@"
	exit 1
}

cmd="kubectl get deployment,ksvc,configuration,revision,route"

msg 'checking that pods are created and all Knative constructs (service, configuration, revision, route) have been deployed:'
msg
msg $cmd

$cmd

