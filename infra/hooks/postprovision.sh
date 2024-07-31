#!/bin/bash

echo "🔶 | Post-provisioning - starting script"

# Retrieve service names, resource group name, and other values from environment variables
resourceGroupName=$AZURE_RESOURCE_GROUP
searchService=$AZURE_SEARCH_NAME
openAiService=$AZURE_OPENAI_NAME

subscriptionId=$AZURE_SUBSCRIPTION_ID
mlProjectName=$AZUREAI_PROJECT_NAME

echo "AZURE_SEARCH_INDEX_SAMPLE_DATA is $AZURE_SEARCH_INDEX_SAMPLE_DATA"
echo "Resource Group Name: $resourceGroupName"
echo "Search Service: $searchService"
echo "OpenAI Service: $openAiService"
echo "Subscription ID: $subscriptionId"
echo "ML Project Name: $mlProjectName"

# Ensure all required environment variables are set
if [ -z "$resourceGroupName" ] || [ -z "$searchService" ] || [ -z "$openAiService" ] || [ -z "$subscriptionId" ] || [ -z "$mlProjectName" ]; then
    echo "One or more required environment variables are not set."
    echo "Ensure that AZURE_RESOURCE_GROUP, AZURE_SEARCH_NAME, AZURE_OPENAI_NAME, AZURE_SUBSCRIPTION_ID, and AZUREAI_PROJECT_NAME are set."
    exit 1
fi

# Environment variables expected by app
echo "AZURE_OPENAI_API_VERSION: $AZURE_OPENAI_API_VERSION"
echo "AZURE_OPENAI_CHAT_DEPLOYMENT: $AZURE_OPENAI_CHAT_DEPLOYMENT"
echo "AZURE_SEARCH_ENDPOINT: $AZURE_SEARCH_ENDPOINT"

# Output environment variables to .env file using azd env get-values
azd env get-values >.env

# Create config.json with required Azure AI project config information
echo "{\"subscription_id\": \"$subscriptionId\", \"resource_group\": \"$resourceGroupName\", \"workspace_name\": \"$mlProjectName\"}" > config.json

# Run sample documents ingestion
echo 'Installing dependencies from "requirements.txt"'
pip cache purge > /dev/null
pip install --upgrade pip setuptools > /dev/null
python -m pip install -r requirements.txt > /dev/null

echo "Populating sample data ...."
python data/sample-documents-indexing.py > /dev/null

echo "🔶 | Post-provisioning - populated data"