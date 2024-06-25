# Steam Deck BIOS Manager

A shell script to easily unlock, download, flash, create BIOS backups, and block / unblock BIOS updates for the Steam Deck running on SteamOS.

**Thanks to [smokeless](https://github.com/SmokelessCPUv2/) and [stanto](https://stanto.com) for the PBS and CBS unlock!\
Thanks to [evlaV gitlab repo](https://gitlab.com/evlaV/jupiter-PKGBUILD) for hosting the Steam Deck (SteamOS 3.x) source code public mirror. Sourced from Valve's latest official (main) source packages.**

No BIOS files are included in this repository - the signed BIOS files are downloaded on-the-fly from evlaV gitlab repository.

**DO NOT DELETE / MODIFY THE MD5.TXT FILE!** \
It contains the md5 hash of the signed BIOS files. If this is modified then the hash sanity check will fail and you wont be able to use this tool to easily flash BIOS.

## What Does it Do?!?
**Answer: it automates a lot of the functions regarding BIOS operations for the Steam Deck running on SteamOS! \
No more need to type manual and complicated commands!**

**a. BACKUP** - this will backup the current BIOS to a directory called ~/BIOS_backup. It will be saved in a file with the following naming convention - 
![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/bc7d465c-f87b-4b97-b410-77d4afc2703f)

**b. BLOCK** - this will prevent SteamOS from automatically applying BIOS updates. Under the hood it performs this tasks - \
   `disables and masks the BIOS update service` \
   `creates a file called /foxnet/bios/INHIBIT` \
   `move the BIOS update file located in /usr/share/jupiter_bios to /usr/share/jupiter_bios/bak`

**c. UNBLOCK** - this will allow SteamOS to automatically apply BIOS updates. Under the hood it performs this tasks - \
   `unmask and enable the BIOS update service` \
   `deletes the file called /foxnet/bios/inhibit` \
   `move the BIOS update file back to the original location /usr/share/jupiter_bios`

**d. SMOKELESS** - this will unlock the BIOS to be able to use Smokeless and also expose the AMD PBS CBS menus. Under the hood it performs this tasks - \
   `download jupiter-bios-unlock from evlaV gitlab repo and make it executable` \
   `perform sanity check - run the unlock tool only if the BIOS version is 110, 113, 115 or 116`

**e. DOWNLOAD** - this will download signed BIOS files from evlaV gitlab repository. Under the hood it performs this tasks - \
   `create BIOS directory where signed BIOS files will be downloaded` \
   `delete any existing files in the BIOS directory (in case there are corrupted BIOS files)` \
   `download signed BIOS files from evlaV gitlab repository`

**f. FLASH** - this will show a menu of available signed BIOS files and user can select which one to flash. Under the hood it performs this tasks - \
   `check if the md5 sum matches to prevent flashing corrupt downloads` \
   `block BIOS updates and backup current BIOS` \
   `perform the BIOS flash` \
![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/d6ad02e3-c6c6-4a11-a113-e4c0ada614b6)

**g. CRISIS** -  this will prepare a USB flash drive for Crisis Mode BIOS flashing - \
   `the inserted USB flash drive will be repartitioned and reformatted as FAT32` \
   `for OLED model - F7G0107_sign.fd will be copied to the USB flash drive as F7GRecovery.fd` \
   `for LCD model - F7A0120_sign.fd will be copied to the USB flash drive as F7ARecovery.fd`


## IMPORTANT INFO ABOUT THE CRISIS MODE! - READ THIS CAREFULLY!
The script will automatically repartition and reformat the USB flash drive as FAT32. \
Make sure to insert the correct USB flash drive and no other flash drives are inserted. \
If your dock has a built-in SSD reader, then do not use the CRISIS mode option of the script! \
**Again - If your dock has a built-in SSD reader, then do not use the CRISIS mode option of the script!**\
Reason for that - it will always be identified as SDA1 and the script will format the built-in SSD reader instead of the actual USB flash drive.
**Again - If your dock has a built-in SSD reader, then do not use the CRISIS mode option of the script!**\


## Prerequisites for SteamOS
1. sudo password should already be set by the end user. If sudo password is not yet set, the script will ask to set it up.

## How to Use
1. Go into Desktop Mode and open a konsole terminal.
2. Clone the github repo. \
   cd ~/ \
   git clone https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager.git
3. Execute the script! \
   cd ~/SteamDeck-BIOS-Manager \
   chmod +x steamdeck-BIOS-manager.sh \
   ./steamdeck-BIOS-manager.sh
   
4. The script will check if sudo passwword is already set.\
![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/15a9d968-2602-43a5-8e7f-54628db00171)

   a. If the sudo password is already set, enter the current sudo password and the script will continue to run and the main menu will be displayed. \
   ![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/83f8f0e7-b1f6-43fb-b577-86ebdc434683)

   b. If wrong sudo password is provided the script will show an error message. Re-run the script and enter the correct sudo password!\
   ![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/8a56e14c-3432-4e94-85fc-7a7e39a3e6d6)
      
   c. If the sudo password is blank / not yet set, the script will prompt to setup the sudo password. Re-run the script again to continue.\
   ![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/8db149de-07f3-40ba-9a96-96bc77da7543)

5. Main menu. Make your selection.\
![image](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/assets/98122529/ca654997-a816-4fa5-867a-631c28d343f2)


