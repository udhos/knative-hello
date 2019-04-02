#!/bin/bash

me=$(basename "$0")
msg() {
    echo >&2 "$me:" "$@"
}

die() {
        msg "$@"
        exit 1
}

[ -n "$DOMAIN" ] || die "missing env var DOMAIN -- example: DOMAIN=35.198.47.138.nip.io"

cat <<__EOF__
DOMAIN=$DOMAIN
__EOF__

dns() {

cat <<__EOF__
apiVersion: v1
data:
  $DOMAIN: ""
kind: ConfigMap
metadata:
  name: config-domain
  namespace: knative-serving
__EOF__

}

msg applying:

dns

dns | kubectl apply -f -
