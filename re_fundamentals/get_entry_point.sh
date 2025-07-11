#!/bin/bash

# Load the display function
source ./messages.sh

file_name="$1"

# Check if file exists
if [[ ! -f "$file_name" ]]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# Check if file is an ELF
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: File '$file_name' is not a valid ELF file."
    exit 1
fi

# Extract required info from ELF header
magic_number=$(hexdump -n 4 -e '4/1 "%02x "' "$file_name")
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | awk '{print $2, $3}')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $4}')

# Show output
display_elf_header_info
