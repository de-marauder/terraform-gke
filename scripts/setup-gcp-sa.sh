#!/bin/bash

set -e

SERVICE_ACCOUNT_NAME='terraform'
ROLE='roles/xxxxxxxx'
PROJECT_ID='shortlet-app-xxxxxx'
USER_EMAIL='xxxxxxxxxx@gmail.com'
KEY_FILE_NAME='terraform-sa-key.json'

# Select project ID
gcloud projects list

# Create the service account
gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME

# To provide access to your project and your resources, grant a role to the service account
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
  --role=$ROLE

# To grant another role to the service account, run the command as you did in the previous step.

# Grant the required role to the principal that will attach the service account to other resources
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com \
  --member="user:$USER_EMAIL" --role=roles/iam.serviceAccountUser

# Create a key for the service account and save it as a JSON file
gcloud iam service-accounts keys create $KEY_FILE_NAME \
    --iam-account=$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com

echo "Service account key saved to $KEY_FILE_NAME"
