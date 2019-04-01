# DNS

Format:

    {route}.{namespace}.{default-domain}

Example:

    gowebhello.default.example.com

Get the domain:

    $ kubectl get ksvc gowebhello
    NAME         DOMAIN                           LATESTCREATED      LATESTREADY        READY   REASON
    gowebhello   gowebhello.default.example.com   gowebhello-kzb8v   gowebhello-kzb8v   True

Get the Knative ingress gateway IP:

    kubectl get svc istio-ingressgateway --namespace istio-system

Edit the domain configuration:

    kubectl edit cm config-domain --namespace knative-serving

Change example.com to your NIP domain (replace 1.2.3.4. with the ingress IP):

apiVersion: v1
data:
  35.198.25.100.nip.io: ""
  # example.com: ""

Check the domain:

    lab@ubu1:~/knative-hello$ kubectl get ksvc gowebhello
    NAME         DOMAIN                                    LATESTCREATED      LATESTREADY        READY   REASON
    gowebhello   gowebhello.default.35.198.25.100.nip.io   gowebhello-kzb8v   gowebhello-kzb8v   True

# References

See: https://github.com/meteatamel/knative-tutorial/blob/master/docs/02-configuredomain.md
