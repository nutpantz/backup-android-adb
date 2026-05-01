#!/bin/bash
clear
adb start-server
export PATH="$PATH:/home/user/android/platform-tools"
echo $PATH
#######looop
######y or n function
ynkey() { 
echo “Press ‘y’ to continue or ‘n’ to exit.”

# Wait for the user to press a key
read -s -n 1 key

# Check which key was pressed
case $key in
y|Y)  #y or Y key
echo “You pressed ‘y’. Continuing…”
;;
n|N) # only n or N key
echo “You pressed ‘n’. Exiting…”
exit 1
;;
*)   #means any key
echo “Invalid input. Please press ‘y’ or ‘n’.”
sleep 2
ynkey  # you pressed not y or n goto back to start
;;
esac
}  # this is the end of the "ynkey" function

###########
adb devices
#adb shell getprop | grep "ro.product.model"
#adb shell settings get global device_name
string="$(adb shell settings get global device_name)"
#echo "$string"
cleanname=$(echo "$string" | tr -d '[:space:]')
echo "device is"
echo "$cleanname"
# Reset BASH time counter
SECONDS=0
echo "total user files backup"
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
echo "doing back up to $backuppath  look good?"

ynkey  # begin ynkey function ask if it all looks good

xxx="/storage/emulated/0/"
####function backup
backup(){
  time_stamp=$(date +%Y_%m_%d)
  # time_stamp=$(date +%Y_%m_%d_%H_%M_%S)
  mkdir -p "${backuppath}/${cleanname}/${time_stamp}"
  #cp -r "${1}" "${backuppath}/${time_stamp}$1"   # removed copy commmand
  adb pull "${xxx}""${1}" "${backuppath}/${cleanname}/${time_stamp}/"
  echo "backup complete in $1"
  echo " "
}

#####################The paths to backup####################
# backup is the function and "download" becomes ${1} varabile
backup "Download"
echo "done"
backup "Mobilism/Mobilism-downloads"
echo "done"
backup "zonewalker-acar"
echo "done"
backup "MyLogs"
echo "done"
backup "Pictures"
echo "done"
backup "1keep"
echo "done"
backup "DCIM"
echo "done"
backup "Diary"
echo "done"
backup "Documents"
echo "done"
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

#seconds=$SECONDS
#ELAPSED="Elapsed: $(($seconds / 3600))hrs $((($seconds / 60) % 60))min $(($seconds % 60))sec"
time=$SECONDS
#printf '%dh:%dm:%ds\n' $(($time/3600)) $(($time%3600/60)) $(($time%60))
printf '%dh:%dm:%ds\n' $(($time/3600)) $(($time%3600/60)) $(($time%60))

read -p "all done now? (y/n) " yn
if [[ $yn == [nN] ]]; then
        echo "ending onew"
        exit 1
fi
echo "it really did not matter what you pressed, we are done"
#adb kill-server
exit 2
