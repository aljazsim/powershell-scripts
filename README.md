# Useful PowerShell scripts
In order to run the scripts from PowerShell make sure you have the appropriate execution policy set.

## Publish NuGet package

This script publishes a NuGet package to https://www.nuget.org/.

Make sure you have the following applications installed:
* Build Tools for Visual Studio 2017 (https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017),
* NuGet (https://www.nuget.org/downloads).

```powershell
.\publishNuGetPackage.ps1 -projectFilePath ".\Source\Project.csproj" -nugetPackageFilePath ".\Source\bin\Release\Project.1.0.5.nupkg" -nugetKey "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
```

## Generate unit test code coverage

This scripts generates unit test project code coverage.

Make sure you have the following applications installed:
* Build Tools for Visual Studio 2017 (https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017),
* VS test console (comes with Visual Studio),
* Open Cover Console (install OpenCover NuGet package into your unit test project),
* Report Generator (install ReportGenerator NuGet package into your unit test project),

```powershell
.\generateUnitTestCodeCoverage.ps1 -solutionFilePath "PathTo\Solution.sln" -unitTestDllFilePath "PathTo\ProjectUnitTest.dll" -openCoverConsole "PathTo\OpenCover.Console.exe" -reportGenerator "PathTo\ReportGenerator.exe"
```

Remarks:
* -solutionFilePath: the path to your solution file,
* -unitTestDllFilePath: the path to the compiled unit test dll,
* -openCoverConsole: the path to open cover console can be found in your NuGet packages directory,
* -reportGenerator: the path to the report generator can be found in your NuGet packages directory.

## Convert SVG image to ICO format

This script generates an ICO format icon from an SVG source file with different icon sizes embedded.

Make sure you have the following applications installed:
* Inkscape (https://inkscape.org/),
* ImageMagick (https://www.imagemagick.org/).

```powershell
.\convertSvgToIco.ps1 -source "icon.svg" -destination "icon.ico"
```