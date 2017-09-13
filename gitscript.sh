#!/bin/bash


#OS_var=$(uname)
#distro_var=$(cat /etc/*-release | head -n1)
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
ZYPPER_CMD=$(which zypper)
PACMAN_CMD=$(which pacman)
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
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get install openssh-server
sudo service ssh start
sudo service ssh status | grep active
elif [[ ! -z $ZYPPER_CMD ]]; then
sudo zypper refresh
sudo zypper up
sudo zypper install openssh-server
else
echo "error can't install ssh...Please install manually"
exit 1;
fi
}
##############################
#SSH setup function for Github
##############################
function git_ssh ()
{
 
while [ -z "$select" ]
do
echo " Now we will create a folder named .ssh in your home directory and generate a public ssh key for ssh cloning from github to your local machine. "
read
clear
cd ~
cd .ssh
echo " Please hit enter multiple times as the key generating prompts are running. No need to enter a paraphrase it will generate one for you."
echo_spacer
ssh-keygen -t rsa
clear
####################
# Distro Functions
####################
function debian_git ()
{
echo " Hit enter to install Github. This will install in the home directory and create a folder named github in the documents directory."
read
cd ~
if [[ ! -z $YUM_CMD ]]; then
sudo yum install git
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get install git
elif [[ ! -z $OTHER_CMD ]]; then
$OTHER_CMD <proper arguments>
else
echo "error can't install package $PACKAGE"
exit 1;
fi
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install git
clear
echo " A folder named github will now be created in the Documents directory. It is recommended to use this folder to organize all your github projects and git clones. Hit enter to continue.."
read
cd Documents 
mkdir github
#####################
#Selection Menu
#####################
while [ -z "$choice" ]
do
echo " Please your distro that you wish to install Github on.. "

       echo " 1. ~Debian-based~ "
            " 2. ~RedHat-based~ "
            " 3. ~OpenSUSE~     "
            " 4. ~ArchLinux~    "
read -r choice;
done
case $choice in
	1) 




