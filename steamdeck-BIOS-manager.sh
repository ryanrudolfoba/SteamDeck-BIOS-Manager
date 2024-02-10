#!/bin/bash

clear

echo Steam Deck BIOS Manager - script by ryanrudolf
echo https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager
echo Easily unlock, download, flash, create BIOS backups, and block / unblock BIOS updates!
sleep 2

# Password sanity check - make sure sudo password is already set by end user!
if [ "$(passwd --status $(whoami) | tr -s " " | cut -d " " -f 2)" == "P" ]
then
	PASSWORD=$(zenity --password --title "sudo Password Authentication")
	echo $PASSWORD | sudo -S ls &> /dev/null
	if [ $? -ne 0 ]
	then
		echo sudo password is wrong! | \
		zenity --text-info --title "Steam Deck BIOS Manager" --width 400 --height 200
		exit
	fi
else
	echo Sudo password is blank! Setup a sudo password first and then re-run script!
	passwd
	exit
fi

# check if this is running on LCD. exit immediately if OLED is detected

echo Current BIOS version is $(sudo dmidecode -s bios-version).
sudo dmidecode -s bios-version | grep -q F7A

if [ $? -eq 0 ]
then
	echo This is a Steam Deck LCD. Proceed with the script.
else
	echo This is a Steam Deck OLED. 
	echo Script only works on Steam Deck LCD. Good bye!
	exit
fi

while true
do
Choice=$(zenity --width 750 --height 320 --list --radiolist --multiple 	--title "Steam Deck BIOS Manager  - https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager"\
	--column "Select One" \
	--column "Option" \
	--column="Description - Read this carefully!"\
	FALSE BACKUP "Create a backup of the current BIOS installed."\
	FALSE BLOCK "Prevent SteamOS from automatically installing new BIOS update."\
	FALSE UNBLOCK "Allow SteamOS to automatically install new BIOS update."\
	FALSE SMOKELESS "Unlock the BIOS v110 to v116 and allow for Smokeless utility."\
	FALSE DOWNLOAD "Download BIOS update from evlaV gitlab repository for manual flashing."\
	FALSE FLASH "Backup and flash BIOS downloaded from evlaV gitlab repository."\
	TRUE EXIT "***** Exit this script *****")

if [ $? -eq 1 ] || [ "$Choice" == "EXIT" ]
then
	echo User pressed CANCEL / EXIT. Goodbye!
	exit

elif [ "$Choice" == "BACKUP" ]
then
	# create BIOS backup and then flash the BIOS
	mkdir ~/BIOS_backup 2> /dev/null
	echo -e "$PASSWORD\n" | sudo -S /usr/share/jupiter_bios_updater/h2offt ~/BIOS_backup/jupiter-$(sudo dmidecode -s bios-version)-bios-backup-$(date +%B%d).bin -O
	zenity --warning --title "Steam Deck BIOS Manager" --text "BIOS backup has been completed!\n\nBackup is saved in BIOS_backup folder." --width 400 --height 75

elif [ "$Choice" == "BLOCK" ]
then
	# this will prevent BIOS updates to be applied automatically by SteamOS
	echo -e "$PASSWORD\n" | sudo steamos-readonly disable
	sudo systemctl mask jupiter-biosupdate
	sudo mkdir -p /foxnet/bios/ 2> /dev/null
	sudo touch /foxnet/bios/INHIBIT 2> /dev/null
	sudo mkdir /usr/share/jupiter_bios/bak 2> /dev/null
	sudo mv /usr/share/jupiter_bios/F* /usr/share/jupiter_bios/bak 2> /dev/null
	sudo steamos-readonly enable
	zenity --warning --title "Steam Deck BIOS Manager" --text "BIOS updates has been blocked!" --width 400 --height 75

elif [ "$Choice" == "UNBLOCK" ]
then
	echo -e "$PASSWORD\n" | sudo -S steamos-readonly disable
	sudo systemctl unmask jupiter-biosupdate
	sudo rm -rf /foxnet 2> /dev/null
	sudo mv /usr/share/jupiter_bios/bak/F* /usr/share/jupiter_bios 2> /dev/null
	sudo rmdir /usr/share/jupiter_bios/bak 2> /dev/null
	sudo steamos-readonly enable
	zenity --warning --title "Steam Deck BIOS Manager" --text "BIOS updates has been unblocked!" --width 400 --height 75

elif [ "$Choice" == "SMOKELESS" ]
then
	curl -s -O --output-dir $(pwd)/ -L https://gitlab.com/evlaV/jupiter-PKGBUILD/-/raw/master/bin/jupiter-bios-unlock
	chmod +x $(pwd)/jupiter-bios-unlock
	echo Checking if BIOS can be unlocked
	if [ "$(echo -e "$PASSWORD\n" | sudo -S dmidecode -s bios-version)" == "F7A0110" ] || \
		[ "$(echo -e "$PASSWORD\n" | sudo -S dmidecode -s bios-version)" == "F7A0113" ] || \
		[ "$(echo -e "$PASSWORD\n" | sudo -S dmidecode -s bios-version)" == "F7A0115" ] || \
		[ "$(echo -e "$PASSWORD\n" | sudo -S dmidecode -s bios-version)" == "F7A0116" ]
		then
			echo BIOS can be unlocked.
			echo -e "$PASSWORD\n" | sudo -S $(pwd)/jupiter-bios-unlock
			zenity --warning --title "Steam Deck BIOS Manager" --text "BIOS has been unlocked for Smokeless.\n\nYou can now use Smokeless or access the AMD PBS CBS menu in the BIOS." --width 400 --height 75
		else
			echo BIOS cant be unlocked.
			zenity --warning --title "Steam Deck BIOS Manager" --text "BIOS $(echo -e "$PASSWORD\n" | sudo dmidecode -s bios-version) cant be unlocked for Smokeless.\n\nFlash BIOS v110 - v116 only for Smokeless." --width 400 --height 75
	fi


elif [ "$Choice" == "DOWNLOAD" ]
then
	# create BIOS directory where the signed BIOS files will be downloaded
	mkdir $(pwd)/BIOS 2> /dev/null

	# if there are existing signed BIOS files then delete them and download fresh copies
	echo cleaning up BIOS directory
	rm -f $(pwd)/BIOS/F7A0???.fd 2> /dev/null
	sleep 2

	# start download from gitlab repository
	echo downloading BIOS 110
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/0660b2a5a9df3bd97751fe79c55859e3b77aec7d/usr/share/jupiter_bios/F7A0110_sign.fd

	echo downloading BIOS 113
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/bf77354719c7a74097a23bed4fb889df4045aec4/usr/share/jupiter_bios/F7A0113_sign.fd

	echo downloading BIOS 115
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/5644a5692db16b429b09e48e278b484a2d1d4602/usr/share/jupiter_bios/F7A0115_sign.fd

	echo downloading BIOS 116
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/38f7bdc2676421ee11104926609b4cc7a4dbc6a3/usr/share/jupiter_bios/F7A0116_sign.fd

	echo downloading BIOS 118
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/f79ccd15f68e915cc02537854c3b37f1a04be9c3/usr/share/jupiter_bios/F7A0118_sign.fd

	echo downloading BIOS 119
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/bc5ca4c3fc739d09e766a623efd3d98fac308b3e/usr/share/jupiter_bios/F7A0119_sign.fd

	echo downloading BIOS 120
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/a43e38819ba20f363bdb5bedcf3f15b75bf79323/usr/share/jupiter_bios/F7A0120_sign.fd

	echo downloading BIOS 121
	curl -s -O --output-dir $(pwd)/BIOS/ -L https://gitlab.com/evlaV/jupiter-hw-support/-/raw/7ffc22a4dc083c005e26676d276bdbd90dd1de5e/usr/share/jupiter_bios/F7A0121_sign.fd

	echo BIOS download complete!

elif [ "$Choice" == "FLASH" ]
then
ls $(pwd)/BIOS/F7A0???_sign.fd &> /dev/null
if [ $? -eq 0 ]
then
	BIOS_Choice=$(zenity --title "Steam Deck BIOS Manager" --width 400 --height 400 --list \
		--column "BIOS Version" $(ls -l $(pwd)/BIOS/F7A0???_sign.fd | sed s/^.*\\/\//) )
	if [ $? -eq 1 ]
	then
		echo User pressed CANCEL. Go back to main menu!
	else
		zenity --question --title "Steam Deck BIOS Manager" --text \
		"Do you want to backup the current BIOS before updating to $BIOS_Choice!\n\nProceed?" --width 400 --height 75
		if [ $? -eq 1 ]
		then
			echo User pressed NO. Ask again before updating the BIOS just to be sure.
			zenity --question --title "Steam Deck BIOS Manager" --text \
			"Current BIOS will be updated to $BIOS_Choice!\n\nProceed?" --width 400 --height 75
			if [ $? -eq 1 ]
			then
				echo User pressed NO.
			else
				echo User pressed YES. Check is BIOS hash is good,

				# check if hash matches before doing any BIOS operations
				if [ "$(md5sum $(pwd)/BIOS/$BIOS_Choice | cut -d " " -f 1)" ==  "$(grep $BIOS_Choice $(pwd)/md5.txt | cut -d " " -f 1)" ]
				then
					echo BIOS hash is good. Performing BIOS operations.

					# this will prevent BIOS updates to be applied automatically by SteamOS
					echo -e "$PASSWORD\n" | sudo steamos-readonly disable
					sudo systemctl mask jupiter-biosupdate
					sudo mkdir -p /foxnet/bios/ 2> /dev/null
					sudo touch /foxnet/bios/INHIBIT 2> /dev/null
					sudo mkdir /usr/share/jupiter_bios/bak 2> /dev/null
					sudo mv /usr/share/jupiter_bios/F* /usr/share/jupiter_bios/bak 2> /dev/null
					sudo steamos-readonly enable

					# create BIOS backup and then flash the BIOS
					echo -e "$PASSWORD\n" | sudo -S /usr/share/jupiter_bios_updater/h2offt $(pwd)/BIOS/$BIOS_Choice
				else
					zenity --warning --title "Steam Deck BIOS Manager" --text \
					"BIOS hash does not match. Corrupted download?.\n\nPerform a DOWNLOAD again and perform the FLASH." \
					 --width 400 --height 75
				fi
			fi
		else
			echo User pressed YES. Check if BIOS hash is good.

			# check if hash matches before doing any BIOS operations
			if [ "$(md5sum $(pwd)/BIOS/$BIOS_Choice | cut -d " " -f 1)"  ==  "$(grep $BIOS_Choice $(pwd)/md5.txt | cut -d " " -f 1)" ]
			then
				echo BIOS hash is good. Performing BIOS operations.

				# this will prevent BIOS updates to be applied automatically by SteamOS
				echo -e "$PASSWORD\n" | sudo steamos-readonly disable
				sudo systemctl mask jupiter-biosupdate
				sudo mkdir -p /foxnet/bios/ 2> /dev/null
				sudo touch /foxnet/bios/INHIBIT 2> /dev/null
				sudo mkdir /usr/share/jupiter_bios/bak 2> /dev/null
				sudo mv /usr/share/jupiter_bios/F* /usr/share/jupiter_bios/bak 2> /dev/null
				sudo steamos-readonly enable

				# create BIOS backup and then flash the BIOS
				mkdir ~/BIOS_backup 2> /dev/null
				echo -e "$PASSWORD\n" | sudo -S /usr/share/jupiter_bios_updater/h2offt \
					~/BIOS_backup/jupiter-$(sudo dmidecode -s bios-version)-bios-backup-$(date +%B%d).bin -O
				echo -e "$PASSWORD\n" | sudo -S /usr/share/jupiter_bios_updater/h2offt $(pwd)/BIOS/$BIOS_Choice
			else
				zenity --warning --title "Steam Deck BIOS Manager" --text \
				"BIOS hash does not match. Corrupted download?.\n\nPerform a DOWNLOAD again and perform the FLASH." --width 400 --height 75
			fi
		fi
	fi
else
	zenity --warning --title "Steam Deck BIOS Manager" --text \
		"BIOS files does not exist.\n\nPerform a DOWNLOAD operation first." --width 400 --height 75
fi
fi
done
