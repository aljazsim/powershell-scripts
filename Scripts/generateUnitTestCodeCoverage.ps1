param(
	$solutionFilePath = "..\Source\Solution.sln",
	$unitTestDllFilePath = "..\Source\ProjectTest\bin\Debug\Project.Test.dll",
	$openCoverConsole = "..\Packages\OpenCover.4.6.519\tools\OpenCover.Console.exe",
	$reportGenerator = "..\Packages\ReportGenerator.3.1.2\tools\ReportGenerator.exe")

$ErrorPreference = 'Stop'

$vsTestConsole = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\Extensions\TestPlatform\vstest.console.exe"
$msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"

$openCoverConsole = [System.IO.Path]::GetFullPath($openCoverConsole)
$reportGenerator = [System.IO.Path]::GetFullPath($reportGenerator)

$solutionFilePath = [System.IO.Path]::GetFullPath($solutionFilePath)
$unitTestDllFilePath = [System.IO.Path]::GetFullPath($unitTestDllFilePath)
$outputDirectory = [System.IO.Path]::GetFullPath(".\GeneratedReports")
$testResultDirectory = [System.IO.Path]::GetFullPath(".\TestResults")
$openCoverReport = [System.IO.Path]::GetFullPath("$outputDirectory\openCoverReport.xml")
$codeCoverageReport = [System.IO.Path]::GetFullPath("$outputDirectory\CodeCoverageReport\index.htm")

Write-Output "------------------------------------------------------- removing old reports -------------------------------------------------------"

if (Test-Path "$outputDirectory")
{
	Remove-Item -Path "$outputDirectory" -Recurse -Force
}

if (Test-Path "$testResultDirectory")
{
	Remove-Item -Path "$testResultDirectory" -Recurse -Force
}

if (Test-Path "$openCoverReport")
{
	Remove-Item -Path "$openCoverReport"
}

New-Item -ItemType Directory "$outputDirectory"

Write-Output "`n`n"
Write-Output "------------------------------------------------------- compiling solution -------------------------------------------------------"
Write-Output "`n"

& "$msbuild"  "$solutionFilePath" /property:Configuration=Release

Write-Output "------------------------------------------------------- running unit tests -------------------------------------------------------"
Write-Output "`n"

& "$openCoverConsole" -register:user -target:$vsTestConsole -targetargs:"$unitTestDllFilePath /Logger:trx" -filter:"+[*]* -[*.Test]*" -mergebyhash -skipautoprops -output:"$openCoverReport"

Write-Output "`n`n"
Write-Output "------------------------------------------------------- generating  code coverage report -------------------------------------------------------"
Write-Output "`n"

& "$reportGenerator" -reports:"$openCoverReport" -targetdir:"$([System.IO.Path]::GetDirectoryName("$codeCoverageReport"))"

& "$codeCoverageReport"

Write-Output "`n`n"
Write-Output "------------------------------------------------------- cleaning up -------------------------------------------------------"
Write-Output "`n"

Remove-Item -Path "$testResultDirectory" -Recurse -Force
Remove-Item -Path "$openCoverReport"