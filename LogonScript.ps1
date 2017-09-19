$ipV4 = Test-Connection -ComputerName $env:ComputerName -Count 1  | Select -ExpandProperty IPV4Address
$Date = Get-Date -format "dd.MM.yyyy HH:mm"
$OutputFile = 'UNCPATH\logons.csv'
$TotalMemory = (Get-WMIObject -class Win32_PhysicalMemory |Measure-Object -Property capacity -Sum | % {[Math]::Round(($_.sum / 1GB),2)})
$String = $Date +", "
$String += $env:UserName +", "
$string += $env:ComputerName  +", "
$string += $ipV4.IPAddressToString +", "
$string += (Get-WmiObject -class Win32_OperatingSystem).Caption +", "
#$string += $ENV:PROCESSOR_ARCHITECTURE
$string += (Get-WmiObject -class Win32_OperatingSystem).OSArchitecture +", "
$string += (Get-WmiObject CIM_ComputerSystem).Model+ " (" + (Get-WmiObject CIM_ComputerSystem).SystemFamily + ") sn:" +(Get-WmiObject Win32_Bios).Serialnumber +", "
$String += [string]$TotalMemory +"GB RAM, "
$String += "IE: " + (Get-ItemProperty 'HKLM:\Software\Microsoft\Internet Explorer').SvcVersion
$string | Out-File $OutputFile -Append


