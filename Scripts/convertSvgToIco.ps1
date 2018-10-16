param(
	$source = "icon.svg",
	$destination = "icon.ico")

$ErrorActionPreference = "Stop"

$inkscape = "C:\Program Files\Inkscape\inkscape.exe"
$magick = "C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe"

$tempDirectoryPath = [System.IO.Path]::GetFullPath(".\temp")
$sourceFilePath = [System.IO.Path]::GetFullPath($source)
$destinationFilePath = [System.IO.Path]::GetFullPath($destination)
$destinationDirectoryPath = [System.IO.Path]::GetDirectoryName($destinationFilePath)

# validate parameters
if (-not (Test-Path -Path $inkscape))
{
	throw "Please install Inkscape (https://inkscape.org/).";
}

if (-not (Test-Path -Path $magick))
{
	throw "Please install Magick (https://www.imagemagick.org/).";
}

if (-not (Test-Path -Path $sourceFilePath))
{
	throw "Source file not found.";
}

# clean up
if (Test-Path -Path $destinationFilePath)
{
	Remove-Item -Path $destinationFilePath -Force
}

if (-not (Test-Path -Path $destinationDirectoryPath))
{
	New-Item -Path "$destinationDirectoryPath" -ItemType Directory
}

if (Test-Path -Path $tempDirectoryPath)
{
	Remove-Item -Path "$tempDirectoryPath\*.*" -Recurse -Force
}
else
{
	New-Item -Path "$tempDirectoryPath" -ItemType Directory
}

# generate PNG icons with transparent background of various sizes from SVG
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon8.png"   -w8   -h8   --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon16.png"  -w16  -h16  --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon24.png"  -w24  -h24  --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon32.png"  -w32  -h32  --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon48.png"  -w48  -h48  --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon64.png"  -w64  -h64  --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon128.png" -w128 -h128 --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon256.png" -w256 -h256 --export-background-opacity=0  | Out-String
& $inkscape -z "$source" --export-png="$tempDirectoryPath\icon512.png" -w512 -h512 --export-background-opacity=0  | Out-String

# combine generated PNG icons into ICO format
& $magick convert `
	"$tempDirectoryPath\icon8.png" `
	"$tempDirectoryPath\icon16.png" `
	"$tempDirectoryPath\icon24.png" `
	"$tempDirectoryPath\icon32.png" `
	"$tempDirectoryPath\icon48.png" `
	"$tempDirectoryPath\icon64.png" `
	"$tempDirectoryPath\icon128.png" `
	"$tempDirectoryPath\icon256.png" `
	"$tempDirectoryPath\icon512.png" `
	"$destinationFilePath"

# clean up
Remove-Item -Path "$tempDirectoryPath\*.*" -Recurse -Force
Remove-Item -path "$tempDirectoryPath"

Write-Output "Icon generated at $destinationFilePath."
