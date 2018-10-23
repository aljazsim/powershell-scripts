param(
	$source = "source.png",
	$destination = "destination.png",
	$width = 50,
	$height = 100)

$ErrorActionPreference = "Stop"
[Environment]::CurrentDirectory = $PWD

$magick = "C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe"

$sourceFilePath = [System.IO.Path]::GetFullPath($source)
$destinationFilePath = [System.IO.Path]::GetFullPath($destination)
$destinationDirectoryPath = [System.IO.Path]::GetDirectoryName($destinationFilePath)

# validate parameters
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

# combine generated PNG icons into ICO format
& $magick convert "$sourceFilePath" -resize "$($width)x$($height)" "$destinationFilePath"

Write-Output "Icon resized at $destinationFilePath."
