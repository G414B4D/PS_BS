# Get all TCP connections
$tcpConnections = Get-NetTCPConnection


# Prepare a collection to hold the results
$results = @()


# Loop through each connection and get process details 
foreach ($connection in $tcpConnections) {
    try {
        # Attempt to get the process PID
        $process = Get-Process -Id $connection.OwningProcess -ErrorAction Stop
        # Add the details to the results collection
        $results += [PSCustomeObject]@{
            LocalAddress = $connection.LocalAddress
            LocalPort = $connection.LocalPort
            RemoteAddress = $connection.RemoteAddress
            RemotePort = $connection.RemotePort
            State = $connection.State
            ProcessName = $process.Name
            PID = $connection.OwningProcess
        }
    } catch {
        # Error handling in case the process cannot be found
        $results += [PSCustomObject]@{
            LocalAddress = $connection.LocalAddress
            LocalPort = $connection.LocalPort
            RemoteAddress = $connection.RemoteAddress
            RemotePort = $connection.RemotePort
            State = $connection.State
            ProcessName = 'Process not found'
            PID = $connection.OwningProcess
        }
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path "C:\desired\output\path\output.csv" -NoTypeInformation

Write-Host "Results exported to C:\path\output\path\output.csv"