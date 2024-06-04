# Define the source directory and template file
$sourceDir = "C:\Users\lucas\Desktop\PRI\enregistrements\Essais_ref"
$templateFile = "C:\Users\lucas\Desktop\PRI\enregistrements\experiment_conditions\benchmarks_martensite.txt"

# Iterate through each folder in the source directory
Get-ChildItem -Path $sourceDir -Directory | ForEach-Object {
    $folderName = $_.Name

    # Define the destination file path
    $destFile = Join-Path -Path $sourceDir -ChildPath "$folderName.txt"

    # Copy the template file to the destination file
    Copy-Item -Path $templateFile -Destination $destFile -Force

    # Modify the first line of the copied file
    $content = Get-Content -Path $destFile
    $content[0] = "Test name : $folderName"
    Set-Content -Path $destFile -Value $content

    Write-Host "Processed folder: $folderName"
}

Write-Host "All folders processed successfully."
