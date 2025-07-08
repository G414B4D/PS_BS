# Parameters for the Matrix effect
$width = 125
$height = 125
$characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"

# Initialize the screen buffer
$screen = @()
for ($i = 0; $i -lt $height; $i++) {
    $line = ""
    for ($j = 0; $j -lt $width; $j++) {
        $line += " "
    }
    $screen += $line
}

# Function to print the screen buffer
function Print-Screen {
    cls
    $screen | ForEach-Object { Write-Host $_ }
}

# Main loop for the Matrix effect
while ($true) {
    for ($i = 0; $i -lt $width; $i++) {
        if ((Get-Random -Minimum 0 -Maximum 100) -lt 10) {  # 10% chance to start a new cascade
            $char = $characters[(Get-Random -Minimum 0 -Maximum $characters.Length)]
            for ($j = 0; $j -lt $height; $j++) {
                if ((Get-Random -Minimum 0 -Maximum 100) -lt 30) {  # 30% chance to continue the cascade
                    $screen[$j] = $screen[$j].Substring(0, $i) + $char + $screen[$j].Substring($i + 1)
                } else {
                    $screen[$j] = $screen[$j].Substring(0, $i) + " " + $screen[$j].Substring($i + 1)
                }
            }
        }
    }
    Print-Screen
    Start-Sleep -Milliseconds 50
}
