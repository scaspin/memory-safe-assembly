#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <output_directory>"
  exit 1
fi

# Set source and output directories
SOURCE_DIR="$1"
OUTPUT_DIR="$2"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Iterate over all files in the source directory
for file in "$SOURCE_DIR"/*; do
  # make sure file has .o ending
  if [[ "$file" == *.o ]]; then
    filename=$(basename "$file")
    output_file="$OUTPUT_DIR/${filename}.dis"
    echo "Disassembling $file to $output_file"
    objdump -d "$file" >"$output_file"
  else
    echo "Skipping $file (not a .o file)"
  fi
done
