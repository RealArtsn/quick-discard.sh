#!/bin/bash
echo "Unplug ALL external storage devices and press ENTER"
read 
echo "The following storage devices will be erased..."
let "i=0"
# iterate through storage devices
lsblk --filter 'TYPE == "disk"' --output SIZE,MODEL --noheadings | while read line
do
    let "++i"
    echo $i: $line
done

echo "Press ENTER to continue..."
read

# blkdiscard all storage devices
lsblk --filter 'TYPE == "disk"' --output NAME --noheadings --paths | while read line
do
    blkdiscard $line
done
