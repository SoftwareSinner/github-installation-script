#!/bin/bash

#OS_var=$(uname)
#distro_var=$(cat /etc/*-release | head -n1)
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
ZYPPER_CMD=$(which zypper)
PACMAN_CMD=$(which pacman)
FEDORA_CMD=$(which dnf)
####################################
#script art
###################################
function git_art ()

{
clear
echo "                                                                         
           MMM.           .MMM                                          
           MMMMMMMMMMMMMMMMMMM
           MMMMMMMMMMMMMMMMMMM      __________________________________________
          MMMMMMMMMMMMMMMMMMMMM    |                                          |
         MMMMMMMMMMMMMMMMMMMMMMM   | Welcome to the github installation script|
        MMMMMMMMMMMMMMMMMMMMMMMM   |_   ______________________________________|
        MMMM::- -:::::::- -::MMMM    |/
         MM~:~   ~:::::~   ~:~MM
    ~  MMMMM::. .:::+:::. .::MMMMM ~ 
          .MM::::: ._. :::::MM.
             MMMM;:::::;MMMM
      -MM        MMMMMMM
      ^  M+     MMMMMMMMM
          MMMMMMM MM MM MM
               MM MM MM MM
               MM MM MM MM
            .~~MM~MM~MM~MM~~.
         ~~~~MM:~MM~~~MM~:MM~~~~
        ~~~~~~~~~~~~~~~~~~~~~~~~
         ~~~~~~~~~~~~~~~~~~~~~~~~"
                                                                


echo " Please hit enter to proceed.. "
read
}
########################################
#echo spacer
#######################################
function echo_spacer ()
{
echo
echo
echo
echo
echo
}
#############################################
#ssh Auth with Github
############################################
function gitssh_auth ()
{
ssh-keygen -t rsa
KEY=$(sudo cat ~/.ssh/id_rsa.pub)
echo "Here is your KEY var: ${KEY}"
clear
read -p "GitHub Username: " USERNAME
read -p "Please enter a title for you ssh key: " TITLE
jq -n --arg t "$TITLE" --arg k "$KEY" '{title: $t, key: $k}' | curl --user "$USERNAME" -X POST --data @- https://api.github.com/user/keys
}
#############################
#ssh download check function
##############################
function ssh_download ()
{
echo " Checking distro and installing ssh..."
if [[ ! -z $YUM_CMD ]]; then
sudo yum install openssh-server
sudo systemctl enable sshd.service
sudo systemctl status sshd.service | grep active
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get install openssh-server
sudo service ssh start
sudo service ssh status | grep active
elif [[ ! -z $ZYPPER_CMD ]]; then
sudo zypper refresh
sudo zypper up
sudo zypper install openssh-server
sudo service ssh start
sudo service ssh status | grep active
elif [[ ! -z $PACMAN_CMD ]]; then
sudo pacman -Syy
sudo pacman -Sy openssh-server
sudo service ssh start
sudo service ssh status | grep active
elif [[ ! -z $FEDORA_CMD ]]; then
sudo dnf install -y openssh-server
sudo systemctl enable sshd.service
sudo systemctl status sshd.service | grep active
else
echo "error can't install ssh...Please install manually"
exit 1;
fi
gitssh_auth
}
#######################################
#Brew for Mac
#######################################
function install_brew_osx() 
{
echo "Now installing brew for OSX"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
####################
#brew check
######################
function brew_check()
{
which brew
if [[ $? != 0 ]]; then
if [[ "$OS_var" == "Darwin" ]]; then
install_brew_osx
brew install git
cd ~
cd Documents 
mkdir -p github
clear
fi
else
brew update
fi
}
####################
# Distro Functions
####################
function distro_git ()
{
echo " Hit enter to install Github. This will install in the home directory."
read
cd ~
if [[ ! -z $YUM_CMD ]]; then
sudo yum install update && sudo yum install upgrade
sudo yum install git
sudo yum install jq
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install git
sudo apt-get install jq
elif [[ ! -z $ZYPPER_CMD ]]; then
sudo zypper up
sudo zypper install git
sudo zypper install jq
elif [[ ! -z $PACMAN_CMD ]]; then
sudo pacman -Syu
sudo pacman -Sy git
sudo pacman -Sy jq
elif [[ ! -z $FEDORA_CMD ]]; then
dnf update
dnf install git
dnf install jq
else
echo "error cannot find distro..."
exit 1;
fi
clear
echo " A folder named github will now be created in the Documents directory. It is recommended to use this folder to organize all your github projects and git clones. Hit enter to continue.."
read
cd ~
cd Documents 
mkdir -p github
}
#####################
#Script Functions
####################
git_art
distro_git
ssh_download 
#install_brew_osx
#brew_check

