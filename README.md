# Steam Deck BIOS Manager

A shell script to easily unlock, download, flash, create BIOS backups, and block / unblock BIOS updates for the Steam Deck running on SteamOS.

No BIOS files or binaries are included in this repository - all the neeed files are downloaded on-the-fly in the evlaV gitlab repository.

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

## What's New (as of November 18 2023)
1. initial release

## What Does it Do?!?
**Answer: it automates a lot of the functions regarding BIOS operations for the Steam Deck running on SteamOS! \
No more need to type manual and complicated commands!**

**a. BACKUP** - this will backup the current BIOS to a directory called ~/BIOS_backup. It will be saved in a file with the following naming convention - 
![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/97010d32-81c8-4519-bba4-100f6bdec139)

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
![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/6801bfac-ec85-44e0-93f8-4f976a6ddbfb)


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
![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/0a004f8d-a840-4867-b897-bae2d1b1395d)

   a. If the sudo password is already set, enter the current sudo password and the script will continue to run and the main menu will be displayed. \
   ![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/afe7d0d5-500f-4bc5-83f1-db14886bd826)

   b. If wrong sudo password is provided the script will show an error message. Re-run the script and enter the correct sudo password!\
![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/41852180-89ce-4d3e-9d91-c25396abfa11)
         
   c. If the sudo password is blank / not yet set, the script will prompt to setup the sudo password. Re-run the script again to continue.\
![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/e3845f99-073c-4fdc-8cab-582ad08b87e8)

5. Main menu. Make your selection.\
![image](https://github.com/ryanrudolfoba/SteamDeck-dualboot/assets/98122529/afe7d0d5-500f-4bc5-83f1-db14886bd826)


