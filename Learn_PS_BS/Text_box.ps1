#Text box testing script 1

# Add .NET assembly to use Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Create a new Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Warning to User!!"
$form.Size = New-Object System.Drawing.Size(450,450)
$form.BackColor = [System.Drawing.Color]::Blue

# Create a label to hold the text
$label = New-Object System.Windows.Forms.Label
$label.Text = "Hello! Just a little background magic running. Don't mind us!"
$label.AutoSize = $true
$label.ForeColor = [System.Drawing.Color]::White  # Setting text color to white for better visibility

# Add label to form
$form.Controls.Add($label)

# Show form
$form.ShowDialog()
