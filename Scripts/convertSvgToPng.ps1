param(
	$source = "icon.svg",
	$destination = "icon.png",
	$width = $null,
	$height = $null)

$ErrorActionPreference = "Stop"

$inkscape = "C:\Program Files\Inkscape\inkscape.exe"

$source = [System.IO.Path]::GetFullPath($source)
$destination = [System.IO.Path]::GetFullPath($destination)
$destinationDirectoryPath = [System.IO.Path]::GetDirectoryName($destination)

# validate parameters
if (-not (Test-Path -Path $inkscape))
{
	throw "Please install Inkscape (https://inkscape.org/).";
}

if (-not (Test-Path -Path $source))
{
	throw "Source file not found.";
}

# clean up
if (Test-Path -Path $destination)
{
	Remove-Item -Path $destination -Force
}

if (-not (Test-Path -Path $destinationDirectoryPath))
{
	New-Item -Path "$destinationDirectoryPath" -ItemType Directory
}

# generate PNG icon with transparent background
if ($width -ne $null -and $height -ne $null)
{
	& $inkscape -z "$source" --export-png="$destination" --export-width $width --export-height $height --export-background-opacity=0 | Out-String
}
elseif ($width -ne $null)
{
	& $inkscape -z "$source" --export-png="$destination" --export-width $width --export-background-opacity=0 | Out-String
}
elseif ($height -ne $null)
{
	& $inkscape -z "$source" --export-png="$destination" --export-height $height --export-background-opacity=0 | Out-String
}
else
{
	throw "Please specify either desired width or height or both.";
}