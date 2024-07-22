# Parametrizing Deployment with GitHub Environments

This document describes how to parametrize deployment by setting variables in the corresponding GitHub Environment (dev, qa, or prod). The variables used in the deployment template are listed below with their descriptions.

All parameters are optional except for `AZURE_ENV_NAME`, `AZURE_LOCATION`, and `AZURE_SUBSCRIPTION_ID`. If you do not want to define specific names for services, they will be generated randomly.

## Variables Table

| Variable Name                      | Description                                         | Default Value                                      |
|------------------------------------|-----------------------------------------------------|----------------------------------------------------|
| `AZURE_ENV_NAME`                   | The name of the Azure environment.                  | -                                                  |
| `AZURE_LOCATION`                   | The location of the Azure resources.                | -                                                  |
| `AZURE_SUBSCRIPTION_ID`            | The subscription ID for the Azure resources.        | -                                                  |
| `AZURE_RESOURCE_GROUP`             | The name of the resource group.                     | random                                             |
| `AZUREAI_RESOURCE_GROUP`           | The name of the AI resource group.                  | random                                             |
| `AZURE_PRINCIPAL_ID`               | The ID of the principal (Service Principal).        | identity of SP set in AZURE_CREDENTIALS secret     |
| `AZUREAI_HUB_NAME`                 | The name of the AI Hub.                             | random                                             |
| `AZUREAI_PROJECT_NAME`             | The name of the AI project.                         | random                                             |
| `AZURE_APP_INSIGHTS_NAME`          | The name of the Application Insights resource.      | random                                             |
| `AZURE_APP_SERVICE_NAME`           | The name of the App Service.                        | random                                             |
| `AZURE_APP_SERVICE_PLAN_NAME`      | The name of the App Service Plan.                   | random                                             |
| `AZURE_CONTAINER_REGISTRY_NAME`    | The name of the Container Registry.                 | random                                             |
| `AZURE_CONTAINER_REPOSITORY_NAME`  | The name of the Container Repository.               | random                                             |
| `AZURE_KEY_VAULT_NAME`             | The name of the Key Vault.                          | random                                             |
| `AZURE_LOG_ANALYTICS_NAME`         | The name of the Log Analytics workspace.            | random                                             |
| `AZURE_OPENAI_NAME`                | The name of the OpenAI resource.                    | random                                             |
| `AZURE_SEARCH_NAME`                | The name of the Search Service.                     | random                                             |
| `AZURE_STORAGE_ACCOUNT_NAME`       | The name of the Storage Account.                    | random                                             |
| `AZURE_SEARCH_INDEX_SAMPLE_DATA`   | The sample data for the Azure Search index.         | true                                               |
| `PROMPTFLOW_WORKER_NUM`            | The number of PromptFlow workers.                   | 1                                                  |
| `PROMPTFLOW_SERVING_ENGINE`        | The PromptFlow serving engine.                      | fastapi                                            |

## Setting Variables in GitHub Environment

To set these variables in your GitHub environment:

1. Navigate to your repository on GitHub.
2. Go to **Settings** > **Environments**.
3. Select or create an environment (e.g., `dev`, `qa`, or `prod`).
4. Add the variables listed in the table above with their corresponding values.

By setting these variables in the GitHub environment, you ensure that your deployment parameters are correctly configured for each environment, facilitating a smooth and consistent deployment process.
