#!/bin/bash


#OS_var=$(uname)
#distro_var=$(cat /etc/*-release | head -n1)
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
ZYPPER_CMD=$(which zypper)
PACMAN_CMD=$(which pacman)
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
read -p "GitHub Username: " uname
read -s -p "GitHub Password: " passwd
if [[ "$uname" == "" || "$passwd" == "" ]]; then
echo -e "\n\nCan't set up your GitHub SSH keys without authorization."
exit 1
fi
token=$(curl -u $uname:$passwd --silent -d '{"scopes":["user"]}' "https://api.github.com/authorizations" | grep -o '[0-9A-Fa-f]\{40\}')
echo -e "\n"
read -p "Generate new (and backup any current) SSH keys? (y):" createkey
if [[ "${createkey:=y}" == "y" ]]; then
echo -e "Generating new SSH keys...\n"
read -p "Enter your email address: " email
mkdir -p ~/.ssh/key_backup && mv ~/.ssh/id_rsa* ~/.ssh/key_backup
echo -e "\n\n\n" | ssh-keygen -t rsa -N "" -C ${email:=null@example.com}
fi
sshkey=`cat ~/.ssh/id_rsa.pub`
curl -X POST -H "Content-type: application/json" -d "{\"title\": \"$email\",\"key\": \"$sshkey\"}" "https://api.github.com/user/keys?access_token=$token"
echo -e "\nAll Done!"
exit 0
}
##############################
#ssh download check function
##############################
function ssh_download ()
{
echo " Checking distro and installing ssh..."
if [[ ! -z $YUM_CMD ]]; then
sudo yum install openssh-server
sudo service ssh start
sudo service ssh status | grep active 
clear
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get install openssh-server
sudo service ssh start
sudo service ssh status | grep active
clear
elif [[ ! -z $ZYPPER_CMD ]]; then
sudo zypper refresh
sudo zypper up
clear
sudo zypper install openssh-server
sudo service ssh start
sudo service ssh status | grep active
clear
elif [[ ! -z $PACMAN_CMD ]]; then
sudo pacman -Syy
sudo pacman install openssh-server
sudo service ssh start
sudo service ssh status | grep active
clear
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
function brew_check()
{
which brew
if [[ $? != 0 ]]; then
if [[ "$OS_var" == "Darwin" ]]; then
install_brew_osx
brew install git
cd ~
cd Documents 
mkdir github
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
echo " Hit enter to install Github. This will install in the home directory and create a folder named github in the documents directory."
read
cd ~
if [[ ! -z $YUM_CMD ]]; then
sudo yum install update && sudo yum install upgrade
sudo yum install git
clear
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install git
clear
elif [[ ! -z $ZYPPER_CMD ]]; then
sudo zypper up
sudo zypper install git
clear
elif [[ ! -z $PACMAN_CMD ]]; then
sudo pacman -Syu
sudo pacman install git
clear
else
echo "error cannot find distro..."
exit 1;
fi
clear
echo " A folder named github will now be created in the Documents directory. It is recommended to use this folder to organize all your github projects and git clones. Hit enter to continue.."
read
cd ~
cd Documents 
mkdir github
}
#####################
#Script Functions
####################
git_art
distro_git
ssh_download 
install_brew_osx
brew_check

