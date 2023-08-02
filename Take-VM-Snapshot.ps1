Connect-VIServer -Server <vCenter_Server_Name> -User <Username> -Password <Password>

$vmName = "vm_name"
$vm = Get-VM -Name $vmName

Write-Host "Taking snapshot for VM: $vmName"
$startTime = Get-Date
$vm | New-Snapshot -Name "SnapshotName" -Description "Snapshot Description" -Quiesce -Memory
Write-Host "Snapshot creation initiated."

# Wait for snapshot creation to complete
while ($vm.ExtensionData.Runtime.PowerState -ne 'PoweredOn') {
    Start-Sleep -Seconds 10
}

$endTime = Get-Date
$snapshotTime = $endTime - $startTime

Write-Host "Snapshot for VM '$vmName' created in: $($snapshotTime.Hours)h $($snapshotTime.Minutes)m $($snapshotTime.Seconds)s."

# Disconnect from the vCenter server
Disconnect-VIServer -Server <vCenter_Server_Name>  -Confirm:$false