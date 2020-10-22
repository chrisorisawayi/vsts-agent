#!/bin/sh

#set env variables
ACR_NAME=hybridaccessdev01
TASK_NAME=vsts-agent-task
IMAGE_NAME=vsts-agent-sql
GIT_USER=chrisorisawayi
GIT_PAT=$(az keyvault secret show --vault-name bootstrap-common-kv --name github-acr-pat --query value -o tsv)

az acr task create \
    --registry $ACR_NAME \
    --name $TASK_NAME \
    --image $IMAGE_NAME:{{.Run.ID}} \
    --arg REGISTRY_NAME=$ACR_NAME.azurecr.io \
    --context https://github.com/$GIT_USER/$IMAGE_NAME \
    --file Dockerfile-app \
    --git-access-token $GIT_PAT
