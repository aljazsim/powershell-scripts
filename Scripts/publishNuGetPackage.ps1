param(
	$projectFilePath = "Project.csproj",
	$nugetPackageFilePath = "Project.1.0.0.nupg",
	$nugetKey = "")

$ErrorPreference = "Stop"
[Environment]::CurrentDirectory = $PWD

$msbuild = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
$nuget = "C:\Program Files (x86)\NuGet\nuget	.exe"

$projectFilePath = [System.IO.Path]::GetFullPath($projectFilePath)
$nugetPackageFilePath = [System.IO.Path]::GetFullPath($nugetPackageFilePath)

# build package
& "$msbuild" "$projectFilePath" /t:pack /p:Configuration=Release

# publish package
& "$nuget" push "$nugetPackageFilePath" $nugetKey -Source https://api.nuget.org/v3/index.json