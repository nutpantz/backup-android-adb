#!/bin/bash
# Reset BASH time counter criticize
adb devices
SECONDS=0
echo "black view backup"
adb shell getprop | grep "ro.build.bluetooth.name"
adb shell getprop | grep "ro.product.vendor.model"
adb shell settings get global device_name
drivers=$(ls /mnt/)

declare -i c=0
for word in $drivers
do
    echo "($c)$word"
    c=c+1
done

read -n 1 drive
echo

c=0
for word in $drivers
do
    if [ $c -eq $drive ]
    then
        backuppath="/mnt/$word/backup"
    fi
    c=c+1
done
echo "doing back up to $backuppath"

xxx="/storage/emulated/0/"

backup(){
  time_stamp=$(date +%Y_%m_%d)
  # time_stamp=$(date +%Y_%m_%d_%H_%M_%S)
  mkdir -p "${backuppath}/bv/${time_stamp}"
  #cp -r "${1}" "${backuppath}/${time_stamp}$1"
  adb pull "${xxx}""${1}" "${backuppath}/bv/${time_stamp}/"
  echo "backup complete in $1"
  echo " "
}

#####################The paths to backup####################

backup "Diary"
backup "Documents"
#backup "Documents/Maps"
#backup "Documents/tombo25"
#backup "Documents/apkbackup"
#backup "Documents/Backup"
#backup "Documents/Callsrec"
#backup "Documents/Contacts"
#backup "Documents/custom sounds"
#backup "Documents/epim"
#backup "Documents/Geocaching"
#backup "Documents/GPS 2024"
#backup "Documents/GPS"
#backup "Documents/gpslogger"
#backup "Documents/Maps"
#backup "Documents/marder"
#backup "Documents/markor"
#backup "Documents/onlinepic"
#backup "Documents/picsforwall"
#backup "Documents/Sync"
#backup "Documents/tombop8p2024-8"
backup "Download"
backup "Mobilism/Mobilism-downloads"
backup "zonewalker-acar"
backup "MyLogs"
backup "Pictures"
backup "1keep"
backup "DCIM"
time=$SECONDS
#printf '%dh:%dm:%ds\n' $(($time/3600)) $(($time%3600/60)) $(($time%60))
printf '%dh:%dm:%ds\n' $(($time/3600)) $(($time%3600/60)) $(($time%60))
