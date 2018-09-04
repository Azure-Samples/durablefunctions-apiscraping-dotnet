param (
    # How to create a token here: https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/
    [string]$githubToken,
    [string]$resourceGroup,
    [string]$storageName,
    [string]$functionName
)

# Creates a Resource group to hold our application
az group create -l eastus -n $resourceGroup

# Storage account where Azure Functions will keep its data and logs
az storage account create --sku Standard_LRS --location EastUS --kind Storage -g $resourceGroup -n $storageName.ToLower()

# Creates our Function Application
az functionapp create -n $functionName -g $resourceGroup -s $storageName.ToLower() -c eastus

# Configures Functions Application Settings
az functionapp config appsettings set -g $resourceGroup -n $functionName --settings GitHubToken=$githubToken