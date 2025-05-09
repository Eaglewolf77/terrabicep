@description('The Azure location to deploy into')
param location        string = 'swedencentral'

@description('Admin username for the VM')
param adminUsername   string

@description('SSH public key for VM login')
param sshpublickey    string

// Virtuellt nätverk
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'bicep-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
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

// Network Interface kopplad till subnätet
resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: 'bicep-nic'
  location: location
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

// Linux-VM med SSH-nyckel
resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'bicep-vm'
  location: location
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
              keyData: sshpublickey
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
