# Useful PowerShell scripts
In order to run the scripts from PowerShell make sure you have the appropriate execution policy set.

## Publish NuGet package

Thus script publishes a NuGet package to https://www.nuget.org/.

Be sure you have msbuild.exe and nuget.exe installed:
*  Build Tools for Visual Studio 2017 (https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017)
* NuGet (https://www.nuget.org/downloads)

```powershell
.\publishNuGetPackage.ps1 -projectFilePath ".\Source\Project.csproj" -nugetPackageFilePath ".\Source\bin\Release\Project.1.0.5.nupkg" -nugetKey "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
```

## Convert SVG image to ICO format

This script generates an ICO format icon from an SVG source file with different icon sizes embedded.

Be sure you have installed the following applications:
* Inkscape (https://inkscape.org/)
* ImageMagick (https://www.imagemagick.org/)

```powershell
.\convertSvgToIco.ps1 -source "icon.svg" -destination "icon.ico"
```