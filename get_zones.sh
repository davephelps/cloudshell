#!/bin/sh
# Login to Azure account
az login
# Get the subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

  # Loop through all resource groups
  for RG in $(az group list --query "[].name" -o tsv)
  do
    # Loop through all app service plans
    for ASP in $(az appservice plan list -g $RG --query "[].name" -o tsv)
    do
      # Check if the app service plan has availability zones enabled
      AZ=$(az appservice plan show -g $RG -n $ASP --query properties.zoneRedundant)
        # Print the app service plan name, resource group, region, and SKU
        echo "$ASP | $RG | $AZ"
    done
done
