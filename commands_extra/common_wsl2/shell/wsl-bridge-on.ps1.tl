if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
        Exit;
    }
}
echo "Checking wsl status..."
wsl --cd ~ -e ls
echo "Geting netadapter..."
Get-NetAdapter
echo "Build a WSL Bridge for <adapter> ..."
Set-VMSwitch WSL -NetAdapterName "<adapter>"
echo "Editing WSL Network configuration..."
wsl --cd ~ -e sh -c ./set_eth0.sh
echo "All done!!"
pause
