# Useful PowerShell scripts
In order to run the scripts from PowerShell make sure you have the appropriate execution policy set.

## Convert SVG image to ICO format

This script generates an ICO format icon from an SVG source file with different icon sizes embedded.

Be sure you have installed the following applications:
* Inkscape (https://inkscape.org/)
* ImageMagick (https://www.imagemagick.org/)

```powershell
.\convertSvgToIco.ps1 -source "icon.svg" -destination "icon.ico"
```