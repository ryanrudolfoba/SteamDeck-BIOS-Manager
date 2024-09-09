# Steam Deck BIOS Manager

A shell script to easily unlock, download, flash, create BIOS backups, and block / unblock BIOS updates for the Steam Deck running on SteamOS.

**Thanks to [smokeless](https://github.com/SmokelessCPUv2/) and [stanto](https://stanto.com) for the PBS and CBS unlock!\
Thanks to [evlaV gitlab repo](https://gitlab.com/evlaV/jupiter-PKGBUILD) for hosting the Steam Deck (SteamOS 3.x) source code public mirror. Sourced from Valve's latest official (main) source packages.**

No BIOS files are included in this repository - the signed BIOS files are downloaded on-the-fly from evlaV gitlab repository.

OPTIONAL - ryzenadj precompiled / built using SteamOS. If you want to build it your own then you need this additional packages -\
gcc\
make\
cmake\
glibc\
glib2\
linux-api-headers\
pciutils

**DO NOT DELETE / MODIFY THE MD5.TXT FILE!** \
It contains the md5 hash of the signed BIOS files. If this is modified then the hash sanity check will fail and you wont be able to use this tool to easily flash BIOS.

> **NOTE**\
> If you are going to use this script for a video tutorial, PLEASE reference on your video where you got the script! This will make the support process easier!
> And don't forget to give a shoutout to [@10MinuteSteamDeckGamer](https://www.youtube.com/@10MinuteSteamDeckGamer/) / ryanrudolf from the Philippines!
>

<b> If you like my work please show support by subscribing to my [YouTube channel @10MinuteSteamDeckGamer.](https://www.youtube.com/@10MinuteSteamDeckGamer/) </b> <br>
<b> I'm just passionate about Linux, Windows, how stuff works, and playing retro and modern video games on my Steam Deck! </b>
<p align="center">
<a href="https://www.youtube.com/@10MinuteSteamDeckGamer/"> <img src="https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/blob/main/10minute.png"/> </a>
</p>

<b>Monetary donations are also encouraged if you find this project helpful. Your donation inspires me to continue research on the Steam Deck! Clover script, 70Hz mod, SteamOS microSD, Secure Boot, etc.</b>

<b>Scan the QR code or click the image below to visit my donation page.</b>

<p align="center">
<a href="https://www.paypal.com/donate/?business=VSMP49KYGADT4&no_recurring=0&item_name=Your+donation+inspires+me+to+continue+research+on+the+Steam+Deck%21%0AClover+script%2C+70Hz+mod%2C+SteamOS+microSD%2C+Secure+Boot%2C+etc.%0A%0A&currency_code=CAD"> <img src="https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/blob/main/QRCode.png"/> </a>
</p>

## Disclaimer
1. Do this at your own risk!
2. This is for educational and research purposes only!

## [Video Tutorial - Steam Deck BIOS Manager](https://youtu.be/hp5ue4m2Xus?si=7cKOB43jIsiEjp2c)
[Click the image below for a video tutorial and to see the functionalities of the script!](https://youtu.be/hp5ue4m2Xus?si=7cKOB43jIsiEjp2c)
</b>
<p align="center">
<a href="https://youtu.be/hp5ue4m2Xus?si=7cKOB43jIsiEjp2c"> <img src="https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/blob/main/banner.png"/> </a>
</p>

## What's New (as of September 08 2024)
1. Supports latest OLED BIOS F7G0112
2. Updated SREP config thanks [stanto!](https://www.stanto.com/steam-deck/how-to-unlock-the-lcd-and-oled-steam-deck-bios-for-increased-tdp-and-other-features/)


## What's New (as of May 10 2024)
1. Supports latest BIOS F7A0131 and F7G0110
2. Added SREP to be able to unlock CBS and PBS (thanks smokeless and [stanto](https://www.stanto.com/steam-deck/how-to-unlock-the-lcd-and-oled-steam-deck-bios-for-increased-tdp-and-other-features/))
3. SREP works from within the internal SSD ESP partition (no need for USB flash drive!)
4. Added precompiled ryzenadj

## What's New (as of April 10 2024)
1. Added support for both Steam Deck LCD and OLED models.
2. h2offt command now uses the -all parameter.
3. added new functionality - Prepare a USB flash drive for Crisis Mode BIOS flashing!
4. code cleanup

## What's New (as of February 10 2024)
1. Added BIOS F7A0121 for LCD model. This BIOS version does not allow overclock. You still need to downgrade to 116 and run smokeless.

## What's New (as of November 30 2023)
1. Since OLED cant be unlocked easily, the script will only work on LCD models.
2. Script will now work on any directory location. (this fixes the issue reported [here](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/issues/4))
3. Script will ask if user wants to skip the backup. (this will take care of the issue reported [here](https://github.com/ryanrudolfoba/SteamDeck-BIOS-Manager/issues/1))



## What's New (as of November 18 2023)
1. initial release

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


