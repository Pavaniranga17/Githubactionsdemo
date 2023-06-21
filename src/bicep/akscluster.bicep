@description('The name of the Managed Cluster resource.')
param clusterName string = 'aks101cluster'
@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location
@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string
@minValue(0)
@maxValue(1023)
@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
param osDiskSizeGB int = 0
@minValue(1)
@maxValue(50)
@description('The number of nodes for the cluster.')
param agentCount int = 2
@description('The size of the Virtual Machine.')
param agentVMSize string = 'Standard_D2s_v3'
@description('User name for the Linux Virtual Machines.')
param linuxAdminUsername string
@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
@secure()
param sshRSAPublicKey = "-----BEGIN OPENSSH PRIVATE KEY-----
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
4zGQ==
-----END OPENSSH PRIVATE KEY-----
"
resource clusterName_resource 'Microsoft.ContainerService/managedClusters@2020-09-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }
  }
}
output controlPlaneFQDN string =clusterName_resource.properties.fqdn