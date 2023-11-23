# Install Chocolatey (if not installed)
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install VirtualBox and Vagrant using Chocolatey
choco install virtualbox -y
choco install vagrant -y

# Remove VBoxManage DHCP server for vboxnet0
& 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' dhcpserver remove --netname HostInterfaceNetworking-vboxnet0

# Set the Vagrant project directory path (root of the C: drive)
$vagrantProjectDir = "C:\Users\User\Documents\Powershell_Automation_Scripts\"

# Change to the Vagrant project directory
Set-Location $vagrantProjectDir

# Remove the existing Vagrantfile (if it exists)
if (Test-Path "Vagrantfile") {
    Remove-Item -Path "Vagrantfile" -Force
}

# Specify the Vagrant box you want to use (Ubuntu 20.04 in this example)
$vagrantBox = "generic/ubuntu2004"

# Run `vagrant init` only if Vagrantfile doesn't exist
if (-not (Test-Path "Vagrantfile")) {
    vagrant init $vagrantBox
}

# Start and provision the Vagrant virtual machine
vagrant up

# Connect to the Vagrant virtual machine via SSH
vagrant ssh


