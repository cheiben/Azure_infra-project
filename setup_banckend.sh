#!/bin/zsh
# This script sets up the backend resources for Terraform state in Azure.

# Create a resource group for state
echo "Creating resource group 'tfstate-rg' in East US..."
az group create --name tfstate-rg --location "East US"

# Create a storage account (name must be globally unique and lowercase)
echo "Creating storage account "
az storage account create \
  --name azure1project \
  --resource-group tfstate-rg \
  --location "East US" \
  --sku Standard_LRS

# Retrieve the storage account key and store it in the ACCOUNT_KEY variable
echo "Retrieving the storage account key..."
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group tfstate-rg \
  --account-name tfstateaccount \
  --query "[0].value" --output tsv)

# Check if the ACCOUNT_KEY variable is populated
if [ -z "$ACCOUNT_KEY" ]; then
  echo "Error: Failed to retrieve the storage account key."
  exit 1
fi

echo "Storage account key retrieved successfully."

# Create a blob container for state
echo "Creating blob container 'tfstate' in the storage account..."
az storage container create \
  --name tfstate \
  --account-name tfstateaccount \
  --account-key "$ACCOUNT_KEY"

echo "Backend storage setup complete."