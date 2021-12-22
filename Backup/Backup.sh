#!/bin/bash
outFile=".../out.txt"
errFile=".../err.txt"
backupDirectory="..."
targetDirectory="..."

date | tee $outFile $errFile
/usr/bin/udisksctl mount -b /dev/sda6 1>> $outFile 2>> $errFile
err=$(rsync -av --delete "$backupDirectory" "$targetDirectory" 1>> $outFile)
echo $err >> $errFile

if [ -n "$err" ]; then
    kdialog --error "rsync Error" --title "Backup Error"
    kate $errFile
fi
