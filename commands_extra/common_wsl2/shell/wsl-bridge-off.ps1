# 检查并以管理员身份运行PS并带上参数
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")
if( -not $isAdmin )
{
    $boundPara = ($MyInvocation.BoundParameters.Keys | foreach{'-{0} {1}' -f  $_ ,$MyInvocation.BoundParameters[$_]} ) -join ' '
    $currentFile = $MyInvocation.MyCommand.Definition
    $fullPara = $boundPara + ' ' + $args -join ' '
    Start-Process "$psHome\pwsh.exe"   -ArgumentList "$currentFile $fullPara"   -verb runas
    return
}
echo "Delete WSL Bridge..."
Set-VMSwitch WSL  -SwitchType Internal
echo "Restart WSL"
wsl --shutdown
wsl --cd ~ -e ls
echo "All Done!"
pause
