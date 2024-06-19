# Define the directory containing your files
$directory = C:\Users\lucas\Desktop\PRI\enregistrements\Essais_ref\benchmarks_martensiteall

$file.Extension =.mat

# Get all files in the directory that match the pattern
$files = Get-ChildItem -Path $directory -Filter "benchmarks_martensite*"

# Initialize a counter
$counter = 1

# Loop through each file and rename it
foreach ($file in $files) {
    # Define the new name
    $newName = "benchmarks_martensiteall_$counter" + $file.Extension
    
    # Rename the file
    Rename-Item -Path $file.FullName -NewName $newName
    
    # Increment the counter
    $counter++
}
