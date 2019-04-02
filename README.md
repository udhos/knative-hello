# knative-hello

knative hello

# Install GCP SDK

See: https://cloud.google.com/sdk/docs/quickstart-linux

Recipe:

    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-231.0.0-linux-x86_64.tar.gz
    tar xf google-cloud-sdk-231.0.0-linux-x86_64.tar.gz
    ./google-cloud-sdk/install.sh
    gcloud components update
    gcloud components install kubectl
    gcloud init

Authorize 'gcloud':

    gcloud auth list
    gcloud auth login

# Grab knative-hello

    git clone https://github.com/udhos/knative-hello

# Create clulster and install knative

    ./knative-install.sh

# Deploy an application

    ./knative-app-deploy.sh ;# will deploy service.yaml

## Deploy V2

    kubectl apply -f service-v2.yaml

## Scale down to one (instead of zero)

    kubectl apply -f service-scaledownto1.yaml

## Split traffic among revisions

CAUTION: Before applying service-split.yaml, edit the file and specify known existing revisions:

    revisions: ["gowebhello-b7kk6", "gowebhello-jfjw6"]

    kubectl apply -f service-split.yaml

# Check knative version

https://www.knative.dev/docs/install/check-install-version/

Get the container image URL with the command below, open it in a browser and look for the tags.

    kubectl describe deploy controller --namespace knative-serving

# Delete everything (the whole cluster)

    ./knative-delete.sh

# Serving logs

Proxy for Kibana UI:

    kubectl proxy --address 0.0.0.0 --accept-hosts '.*'

Open: http://localhost:8001/api/v1/namespaces/knative-monitoring/services/kibana-logging/proxy/app/kibana

https://www.knative.dev/docs/serving/accessing-logs/

# Knative install docs

https://www.knative.dev/docs/install/knative-with-gke/

