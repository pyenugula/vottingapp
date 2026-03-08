#! /bin/bash 
set -x
resoureceGroupName="tfstate$RANDOM"
location="centralus"
storageaccountname="tfstate$RANDOM"
containerName="tfstate"

# Create a resource group.
az group create --name $resoureceGroupName --location $location
# Create a storage account.
az storage account create --name $storageaccountname --resource-group $resoureceGroupName --sku Standard_LRS --encryption-services blob 

# Create a storage container.
az storage container create --name $containerName --account-name $storageaccountname
