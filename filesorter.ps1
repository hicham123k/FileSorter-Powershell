
$fileTypes = @{
    'PDFs'      = @('pdf')
    'Videos'    = @('mp4', 'avi', 'mkv', 'mov', 'wmv')
    'Music'     = @('mp3', 'wav', 'flac', 'aac')
    'Pictures'  = @('jpg', 'jpeg', 'png', 'gif', 'bmp', 'tiff')
}

$sourceDirectory = Get-Location

foreach ($category in $fileTypes.Keys) {
    $destinationFolder = Join-Path -Path $sourceDirectory -ChildPath $category
    if (!(Test-Path -Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder
    }
}

Get-ChildItem -Path $sourceDirectory -File | ForEach-Object {
    $fileExtension = $_.Extension.Replace('.', '').ToLower()
    
    foreach ($category in $fileTypes.Keys) {
        if ($fileExtension -in $fileTypes[$category]) {
            $destinationFolder = Join-Path -Path $sourceDirectory -ChildPath $category
            Move-Item -Path $_.FullName -Destination $destinationFolder -Force
            Write-Host "Moved '$($_.Name)' to '$category' folder."
            break
        }
    }
}
