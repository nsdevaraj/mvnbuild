 param (
    [string]$version = "1.0",
    [string]$compID = "com.adam.test"
 )
$PathDir = (Get-Item -Path ".\" -Verbose).FullName
#master pom


$configFiles = Get-ChildItem . -Include *.xml, *.ztl, *.MF -rec
foreach ($file in $configFiles)
{
	(Get-Content $file.PSPath).replace('[cdVal]',$PathDir ) | Set-Content $file.PSPath	
	(Get-Content $file.PSPath).replace('[componentID]',$compID ) | Set-Content $file.PSPath
	(Get-Content $file.PSPath).replace('[componentVer]',$version ) | Set-Content $file.PSPath
}