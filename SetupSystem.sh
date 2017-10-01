#!/bin/bash

#Start
clear
echo "System setup/update script"
sleep 1

if [ "$1" = "u" ]
then
	echo "Update|Upgrade|Autoremove"
	yes | sudo apt update 
	yes | sudo apt upgrade 
	yes | sudo apt autoremove
	clear
	exit 0
fi

#SublimeText install
read -p "Install Sublime Text?(Y/n)" input
case $input in
	[nN] ) ;;
	[yY]|"" ) 
		echo "Downloading..."
		wget https://download.sublimetext.com/sublime-text_build-3143_amd64.deb
		echo "Installing..."
		sudo dpkg -i ~/Downloads/sublime-text_build-3143_amd64.deb
		rm sublime-text_build-3143_amd64.deb*
		;;
esac

#Spotify install
read -p "Install Spotify?(Y/n)" input
case $input in
	[nN] ) ;;
	[yY]|"" ) 
		echo "Add the Spotify repository signing key to be able to verify downloaded packages"
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
		echo "Add the Spotify repository"
		echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
		echo "Update list of available packages"
		sudo apt update
		echo "Install Spotify"
		yes | sudo apt install spotify-client
		;;
esac

#Git install
read -p "Install Git?(Y/n)" input
case $input in
	[nN] ) ;;
	[yY]|"" ) 
		yes | sudo apt install git
		read -p "Git User Name:" username
		git config --global user.name $username
		read -p "Git User eMail:" usermail
    		git config --global user.email $usermail
    		read -p "Save Git credentials for an hour?(Y/n)" input
		case $input in
			[nN] ) ;;
			[yY]|"" )
				git config --global credential.helper cache
    				git config --global credential.helper 'cache --timeout=3600'
				;;
		esac
		;;
esac

#Chromium install
read -p "Install Chromium?(Y/n)" input
case $input in
	[nN] ) ;;
	[yY]|"" ) 
		yes | sudo apt install chromium-browser
		;;
esac

#AndroidStudio install
read -p "Install Android Studio?(Y/n)" input
case $input in
	[nN] ) ;;
	[yY]|"" ) 
		echo "Installing Ubuntu Make..."
		yes | sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
		yes | sudo apt install ubuntu-make
		sudo apt-get update
		echo "Installing Android Studio..."
		umake android
		;;
esac

sleep 1
clear
