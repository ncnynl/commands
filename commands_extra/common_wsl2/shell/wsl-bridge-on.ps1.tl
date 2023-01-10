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
#首先随意执行一条wsl指令，确保wsl启动，这样后续步骤才会出现WSL网络
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
