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

    ./knative-app-deploy.sh

# Check knative version

https://www.knative.dev/docs/install/check-install-version/

Get the container image URL with the command below, open it in a browser and look for the tags.

    kubectl describe deploy controller --namespace knative-serving

# Delete everything (the whole cluster)

    ./knative-delete.sh

# Knative install docs

https://www.knative.dev/docs/install/knative-with-gke/

