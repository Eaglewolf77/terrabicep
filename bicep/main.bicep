param location string = 'swedencentral'
param adminUsername string
param sshPublicKey string
param resourceGroupName string = 'terrabicep'

resource existingRg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: resourceGroupName
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'bicep-vnet'
  location: location
  scope: existingRg
  properties: {
    addressSpace: {
      addressPrefixes: ['10.1.0.0/16']
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.1.0.0/24'
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: 'bicep-nic'
  location: location
  scope: existingRg
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'bicep-vm'
  location: location
  scope: existingRg
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      computerName: 'bicepvm'
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: sshPublicKey
            }
          ]
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
  }
}
