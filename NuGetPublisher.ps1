# LiveScore Infrastructure NuGet Build-Pack-Push Process
# This file needs to be in the solution folder to be executed correctly.
# Usage: Run on Powershell in Windows 10 Environment with following execution policy.
# Set-ExecutionPolicy Unrestricted

 #$basedir = "C:\Projects\BB\infrastructure.canliskor.com.tr"
  $basedir = $PSScriptRoot

 $folders = @(
  "Jil"
)
# Powershell -ExecutionPolicy ByPass  çalıştırılmalıdır.

foreach($folder in $folders) {
  $currentdir = $basedir + "\" + $folder + "\bin\Release\";
  $latestCsProj = Get-ChildItem -Path $basedir\$folder\*.csproj | Sort-Object LastAccessTime -Descending | Select-Object -First 1
  dotnet build $latestCsProj -c Release 
  dotnet pack $latestCsProj -c Release 
  $latestNupkg = Get-ChildItem -Path $currentdir\*.nupkg | Sort-Object LastAccessTime -Descending | Select-Object -First 1
  $nupkg = $currentdir + $latestNupkg.name
  dotnet nuget push $nupkg -k <<ENTER-MYGET-KEY-HERE>> --source https://www.myget.org/F/<<ENTER-REPO-NAME-HERE>></api/v2/package  
  }