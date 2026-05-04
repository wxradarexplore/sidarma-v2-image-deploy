param(
  [string]$ListenAddress = "10.20.220.22",
  [string]$ConnectAddress = "172.19.20.18",
  [int]$Port = 8000
)

netsh interface portproxy delete v4tov4 listenaddress=$ListenAddress listenport=$Port | Out-Null
netsh interface portproxy add v4tov4 listenaddress=$ListenAddress listenport=$Port connectaddress=$ConnectAddress connectport=$Port

$ruleName = "SIDARMA API $Port"
$exists = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
if (-not $exists) {
  New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Action Allow -Protocol TCP -LocalPort $Port | Out-Null
}

Write-Host "Portproxy configured: $ListenAddress`:$Port -> $ConnectAddress`:$Port"
