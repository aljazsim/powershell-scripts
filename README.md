# Useful PowerShell scripts
This is a collection of useful PowerShell scripts. In order to run the scripts from PowerShell make sure you have the appropriate ![execution policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-6){:target="_blank"} set.

## Publish a NuGet package

This ![script](./Scripts/publishNuGetPackage.ps1 "script") publishes a NuGet package to https://www.nuget.org/ for a .NET project.

Make sure you have the following applications installed:
* Build Tools for Visual Studio 2017 (https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017),
* NuGet (https://www.nuget.org/downloads).

```powershell
.\publishNuGetPackage.ps1 -projectFilePath ".\Source\Project.csproj" -nugetPackageFilePath ".\Source\bin\Release\Project.1.0.5.nupkg" -nugetKey "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
```

Parameters:
* -projectFilePath: the .NET project file path,
* -nugetPackageFilePath: the file path of the NuGet package generated by msbuild,
* -nugetKey: the NuGet authentication key.

## Generate a unit test project code coverage

This ![script](./Scripts/generateUnitTestCodeCoverage.ps1 "script") generates a unit test project code coverage for a .NET solution.

Make sure you have the following applications installed:
* Build Tools for Visual Studio 2017 (https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2017),
* VS test console (comes with Visual Studio),
* Open Cover Console (install OpenCover NuGet package into your unit test project),
* Report Generator (install ReportGenerator NuGet package into your unit test project).

```powershell
.\generateUnitTestCodeCoverage.ps1 -solutionFilePath "PathTo\Solution.sln" -unitTestDllFilePath "PathTo\ProjectUnitTest.dll" -openCoverConsole "PathTo\OpenCover.Console.exe" -reportGenerator "PathTo\ReportGenerator.exe"
```

Parameters:
* -solutionFilePath: the path to your solution file,
* -unitTestDllFilePath: the path to the compiled unit test dll,
* -openCoverConsole: the path to open cover console can be found in your NuGet packages directory,
* -reportGenerator: the path to the report generator can be found in your NuGet packages directory.

## Resize an image

This ![script](./Scripts/resizeImage.ps1 "script") will resize the specified image.

Make sure you have the following applications installed:
* ImageMagick (https://www.imagemagick.org/).

```powershell
.\resizeImage.ps1 -source ".\icon.png" -destination ".\resized\icon.png" -width 300
```

Parameters:
* -source: the source file path,
* -destination: the destination file path,
* -width: the destination file width in pixels,
* -height: the destination file height in pixels.

Either destination file width, height or both have to be specified.

If you want to resize an entire directory of image files, you can use this snippet:

```powershell
Get-ChildItem "." -Filter "*.png" | ForEach-Object { .\resizeImage.ps1 -source $_.FullName -destination ".\resized\$($_.Name)" -width 300 }
```

## Convert SVG image to PNG format

This ![script](./Scripts/convertSvgToPng.ps1 "script") generates a PNG format icon from an SVG source file with the specified dimensions.

Make sure you have the following application installed:
* Inkscape (https://inkscape.org/).

```powershell
.\convertSvgToPng.ps1 -source "icon.svg" -destination "icon.png" -width 300 -height 450
```

Parameters:
* -source: the source file path in SVG format,
* -destination: the destination file path in PNG format,
* -width: the destination file width in pixels,
* -height: the destination file height in pixels.

Either destination file width, height or both have to be specified.

If you want to convert an entire directory of SVG files to PNG files, you can use this snippet:

```powershell
Get-ChildItem ".\svgs" -Filter "*.svg" | ForEach-Object { .\convertSvgToPng.ps1 -source $_.FullName -destination ".\pngs\$([System.IO.Path]::GetFileNameWithoutExtension($_.Name)).png" -width 300 }
```

## Convert SVG image to ICO format

This ![script](./Scripts/convertSvgToIco.ps1 "script") generates an ICO format icon from an SVG source file with different icon sizes embedded.

Make sure you have the following applications installed:
* Inkscape (https://inkscape.org/),
* ImageMagick (https://www.imagemagick.org/).

```powershell
.\convertSvgToIco.ps1 -source "icon.svg" -destination "icon.ico"
```

Parameters:
* -source: the source file path in SVG format,
* -destination: the destination file path in ICO format.

If you want to convert an entire directory of SVG files to ICO files, you can use this snippet:

```powershell
Get-ChildItem ".\svgs" -Filter "*.svg" | ForEach-Object { .\convertSvgToIco.ps1 -source $_.FullName -destination ".\icos\$([System.IO.Path]::GetFileNameWithoutExtension($_.Name)).ico" }
```