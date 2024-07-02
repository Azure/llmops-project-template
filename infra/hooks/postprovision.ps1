Write-Host "Starting postprovisioning..."

# Retrieve service names, resource group name, and other values from environment variables
$resourceGroupName = $env:AZURE_RESOURCE_GROUP
Write-Host "resourceGroupName: $resourceGroupName"

$openAiService = $env:AZURE_OPENAI_NAME
Write-Host "openAiService: $openAiService"

$subscriptionId = $env:AZURE_SUBSCRIPTION_ID
Write-Host "subscriptionId: $subscriptionId"

$aiProjectName = $env:AZUREAI_PROJECT_NAME
Write-Host "aiProjectName: $aiProjectName"

$searchService = $env:AZURE_SEARCH_NAME
Write-Host "searchService: $searchService"

# Determine if indexing sample data is required
$indexSampleData = if ($null -eq $env:AZURE_SEARCH_INDEX_SAMPLE_DATA -or $env:AZURE_SEARCH_INDEX_SAMPLE_DATA -eq "true") { $true } else { $false }
Write-Host "indexSampleData: $indexSampleData"


# Ensure all required environment variables are set
if ([string]::IsNullOrEmpty($resourceGroupName) -or [string]::IsNullOrEmpty($openAiService) -or [string]::IsNullOrEmpty($subscriptionId) -or [string]::IsNullOrEmpty($aiProjectName)) {
    Write-Host "One or more required environment variables are not set."
    Write-Host "Ensure that AZURE_RESOURCE_GROUP, AZURE_OPENAI_NAME, AZURE_SUBSCRIPTION_ID, and AZUREAI_PROJECT_NAME are set."
    exit 1
}

# Set additional environment variables expected by app 
# TODO: Standardize these and remove need for setting here
azd env set AZURE_OPENAI_API_VERSION 2023-03-15-preview
azd env set AZURE_OPENAI_CHAT_DEPLOYMENT gpt-35-turbo
azd env set AZURE_SEARCH_ENDPOINT $AZURE_SEARCH_ENDPOINT

# Output environment variables to .env file using azd env get-values
azd env get-values > .env
Write-Host "Script execution completed successfully."

Write-Host 'Installing dependencies from "requirements.txt"'
python -m pip install -r flow/requirements.txt > $null

if ($indexSampleData -eq $true) {
    # populate data
    Write-Host "Populating data ...."
    jupyter nbconvert --execute --to python --ExecutePreprocessor.timeout=-1 data/sample-documents-indexing.ipynb > $null
}