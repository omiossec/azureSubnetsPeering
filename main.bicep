
var vnetAName= 'vnet1'
var vnetBName= 'vnet2'

var vnetlocation= 'westeurope'

var vnetAPrefix  = [
  '10.0.0.0/24'
]

var vnetBPrefix  = [
  '10.0.1.0/24'
]


var subnetsVnetA  = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.0.0/26'
    privateEndpointNetworkPolicies: 'disabled'
    privateLinkServiceNetworkPolicies: 'disabled'
  }
  {
    name: 'subnet2'
    addressPrefix: '10.0.0.64/26'
    privateEndpointNetworkPolicies: 'disabled'
    privateLinkServiceNetworkPolicies: 'disabled'
  }
]



var subnetsVnetB  = [
  {
    name: 'subnet1'
    addressPrefix: '10.0.1.0/26'

  }
  {
    name: 'subnet2'
    addressPrefix: '10.0.1.64/26'

  }
]


resource vnetA 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetAName
  location: vnetlocation
  properties: {
    addressSpace: {
      addressPrefixes: vnetAPrefix
    }
    subnets: [for subnet in subnetsVnetA: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix

      }
    }]
  }
}

resource vnetB 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetBName
  location: vnetlocation
  properties: {
    addressSpace: {
      addressPrefixes: vnetBPrefix
    }
    subnets: [for subnet in subnetsVnetB: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix

      }
    }]
  }
}


resource VnetPeeringA 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-01-01' = {
  parent: vnetA
  name: '${vnetAName}-${vnetBName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    peerCompleteVnets: false
    localSubnetNames: [
      'subnet1'
    ]
    remoteSubnetNames: [
      'subnet1'
    ]
    remoteVirtualNetwork: {
      id: vnetB.id
    }
  }
}

resource VnetPeeringB 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-01-01' = {
  parent: vnetB
  name: '${vnetBName}-${vnetAName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    peerCompleteVnets: false
    localSubnetNames: [
      'subnet1'
    ]
    remoteSubnetNames: [
      'subnet1'
    ]
    remoteVirtualNetwork: {
      id: vnetA.id
    }
  }
}
