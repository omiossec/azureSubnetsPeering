# Azure Bicep Subnets peering


## Azure CLI code 

```
az feature register --namespace Microsoft.Network --name AllowMultiplePeeringLinksBetweenVnets 


az feature show --name AllowMultiplePeeringLinksBetweenVnets --namespace Microsoft.Network --query 'properties.state' -o tsv Registering




 az network vnet peering create -n "vnet1-vnet2" -g 001testolivier -o none --vnet-name vnet1 --remote-vnet vnet2 --allow-forwarded-traffic --allow-vnet-access --peer-complete-vnet false --local-subnet-names subnet1 --remote-subnet-names subnet1

         az network vnet peering create -n "vnet2-vnet1" -g 001testolivier -o none --vnet-name vnet2 --remote-vnet vnet1 --allow-forwarded-traffic --allow-vnet-access --peer-complete-vnet false --local-subnet-names subnet1 --remote-subnet-names subnet1
```
