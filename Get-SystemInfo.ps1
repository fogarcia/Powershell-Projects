# Get-SystemInfo.ps1

function Get-SystemInfo {
    $sysInfo = @{
        "OS Version" = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
        "Computer Name" = $env:COMPUTERNAME
        "Processor" = (Get-CimInstance -ClassName Win32_Processor).Name
        "Total Physical Memory (MB)" = [math]::Round((Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1MB, 2)
        "Free Physical Memory (MB)" = [math]::Round((Get-CimInstance -ClassName Win32_OperatingSystem).FreePhysicalMemory / 1MB, 2)
    }
    return $sysInfo
}

$info = Get-SystemInfo
Write-Output "System Information:"

foreach ($item in $info.GetEnumerator()) {
    Write-Output "$($item.Key): $($item.Value)"
}

$outputPath = "C:\SystemInfo.txt"
$info | Out-File -Filepath $outputPath
Write-Output "`nInfo Svaved to $outputPath"
