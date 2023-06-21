@description('The name of the Managed Cluster resource.')
param clusterName string = 'aks101cluster'

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string = myaksdns007'
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
param linuxAdminUsername string = 'myaksuser'

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
@secure()
param sshRSAPublicKey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDzRH93GY+eJ1UfTkH5ufTKLue0Ert3jbjgXY6/o+77XlQUKEhRCKNbYAJW+LzBgsJbbN9j8y/F6hv8E9f40OIROmcQ4diXY98FnSAR6gyhqXaHUHcxcQQQPiDwBnkWWcGxLdFLrvB/1SDY17YBCR8DQPan3YfogTlD4PdcUT+iONAuNBFjWHUfMyYvjjo/7DcwdqpqiKKPdycGtnIQcwkHwqwANZa1FiXrObLtQAQZ0V302ZWYBbwfDV8RpfqXCanWRTFO/6RHkM6TNoQVQCNT41Y5k3dM3TbjDLfncpZHRQ0Jf62cvkeLz3qMOYARmz4Q257VLknKxjPonLd5LhoBhIOVbw0db4CDOi27ntLYvt8fScBzYbV74dfj1TrTthI425KzNTBs13MCg83v/jCYtmBg1RzQFPnau4bxOxWDkJXbVfJPSnJEZlGpWzTpUZDR+6Ld2FjPkjQ26b8ESETUGHQ5ZaCxWdbCI6Pkw0+znd5isof7cAwTuEDlIbbNgkE= generated-by-azure'

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