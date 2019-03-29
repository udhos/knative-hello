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

    gcloud auth login

# Grab knative-hello

    git clone https://github.com/udhos/knative-hello

# Run script

    ./knative-install.sh
