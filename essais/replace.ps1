# Define the root directory
$rootDirectory = "C:\Users\lucas\Desktop\PRI_Lucas\enregistrements\essais"

# Function to rename folders and files recursively
function Rename-ItemsRecursively {
    param (
        [Parameter(Mandatory=$true)]
        [string]$directory
    )

    # Get all items (files and directories) in the current directory
    $items = Get-ChildItem -Path $directory

    foreach ($item in $items) {
        # Rename directories
        if ($item.PSIsContainer) {
            $newName = $item.Name -replace 'benchmarks', 'calibration'
            $newPath = Join-Path -Path $directory -ChildPath $newName
            Rename-Item -Path $item.FullName -NewName $newName -ErrorAction SilentlyContinue
            Rename-ItemsRecursively -directory $newPath  # Recursively call for subdirectories
        }
        else {  # Rename files
            $newName = $item.Name -replace 'benchmarks', 'calibration'
            $newPath = Join-Path -Path $directory -ChildPath $newName
            Rename-Item -Path $item.FullName -NewName $newName -ErrorAction SilentlyContinue
        }
    }
}

# Call the function to start renaming recursively from the root directory
Rename-ItemsRecursively -directory $rootDirectory
