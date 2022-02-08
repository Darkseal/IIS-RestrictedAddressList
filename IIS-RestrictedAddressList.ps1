$defaultExportFile = (Get-Item -Path '.\' -Verbose).FullName + "\" + "IPRestricted_ExportList.txt"
[string]$SitesVar = Read-Host "Enter one or more websites, separated by ','"
$exportFile = Read-Host "Enter the full export file name and path (default: '$defaultExportFile')"
 
sl c:\windows\system32\inetsrv\ 
 
$a = 0 
$sites = $SitesVar.Split(",")
$count = $Sites.count 
if ($exportFile -eq "") { 
  $exportFile = $defaultExportFile
}
if (Test-Path $exportFile) {
  Remove-Item $exportFile
}
do { 
  foreach ($site in $sites){ 
    $site = $site.Trim()
    Add-Content -Path  $exportFile -Value "---------------------------------------------"
    Add-Content -Path  $exportFile -Value $site
    Add-Content -Path  $exportFile -Value "---------------------------------------------"
    [xml]$out = .\appcmd.exe list config $site -section:system.webServer/security/ipSecurity  
    $out."system.webserver"."security"."ipsecurity" | %{ 
	   Add-Content -Path  $exportFile -Value ($_.innerxml.Split("<*>/",[System.StringSplitOptions]::RemoveEmptyEntries) -replace "add ", "" -join "`n")
       # $_.innerxml.Split("<*>/",[System.StringSplitOptions]::RemoveEmptyEntries) -replace "add ", "" -join "`n" | out-file -FilePath $exportFile
    } 
    Add-Content -Path  $exportFile -Value "`n"
    $a++ 
  } 
}
while ($a -ne $count) 
