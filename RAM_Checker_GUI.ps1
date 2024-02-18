Add-Type -AssemblyName System.Windows.Forms

# Get compute resource information, included but not limited to RAM
$ram_info = Get-CimInstance -ClassName Win32_ComputerSystem

# As the above gives you your RAM in bytes, we can make it more readable by converting it to GB:
$total_memory_gb = [math]::Round($ram_info.TotalPhysicalMemory / 1GB, 2)

# Determine message based on different levels
if ($total_memory_gb -lt 4) {
    $message = "Consider upgrading for better performance."
} elseif ($total_memory_gb -lt 8) {
    $message = "It's suitable for most tasks."
} else {
    $message = "You have ample resources for demanding applications."
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "System RAM Information"
$form.Width = 400
$form.Height = 200

# Create labels to display RAM information and message
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10, 20)
$label1.Size = New-Object System.Drawing.Size(380, 20)
$label1.Text = "Your total physical memory is $total_memory_gb GB."

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10, 50)
$label2.Size = New-Object System.Drawing.Size(380, 20)
$label2.Text = $message

# Add labels to the form
$form.Controls.Add($label1)
$form.Controls.Add($label2)

# Show the form
$form.ShowDialog() | Out-Null
