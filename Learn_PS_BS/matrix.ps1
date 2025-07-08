# Set console title
$host.UI.RawUI.WindowTitle = "Matrix Effect"

# Function to check if a key is pressed
function IsKeyPressed {
    return [Console]::KeyAvailable
}

# Main loop
try {
    while ($true) {
        # Print a random 1 or 0 without a newline
        Write-Host -NoNewline $(Get-Random -Minimum 0 -Maximum 2)

        # Check for a key press
        if (IsKeyPressed) {
            # Read the key (and ignore it), so the loop will exit
            $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            break
        }

        # Sleep a bit to make the output readable
        Start-Sleep -Milliseconds .5
    }
} finally {
    # Clear the console when done
    Clear-Host
    Write-Host "Exiting Matrix Effect..."
}