#!/bin/bash

# Define variables
base_url="https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate_urban/hourly/wind/recent"
file_name="stundenwerte_wind_399_akt.zip"
output_dir="C:\Users\a_n_n\OneDrive\Obsidian\Uni_Dell\Studying\MachineLearning_DataScience\project\most_recent_wind_data"
zip_file="${output_dir}/${file_name}"
target_file="produkt_wind_399_akt.txt"  # Replace with the actual target file name inside the zip

# Remove the output directory if it exists (so I can always update the data when newer one comes in)
if [[ -d $output_dir ]]; then
    rm -rf $output_dir
    echo "Dir deleted"
fi

# Create the output directory if it doesn't exist
mkdir -p $output_dir
echo "Dir created"

# Download the file
curl -o $zip_file "${base_url}/${file_name}"
echo "Downloaded file to ${zip_file}"

# Unzip the file
unzip -o $zip_file -d $output_dir
echo "Extracted files to ${output_dir}"

# Locate the target file (you might need to adjust this part based on your zip file structure)
extracted_file_path=$(find $output_dir -name $target_file)

# Check if the target file exists
if [[ ! -f $extracted_file_path ]]; then
    echo "Error: ${target_file} not found in the extracted files."
    exit 1
fi

# Read the target file (example of reading a CSV file and printing the first 5 lines)
head -n 5 $extracted_file_path

# Further processing can be done here
