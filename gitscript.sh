#!/bin/bash


OS_var=$(uname)
distro_var=$(cat /etc/*-release | head -n1)





##############################
#ssh download check function
##############################
function ssh_download ()

{


if [[ $? != 0 ]]; then 

if [[ "$OS_var" == "Linux" ]]; then

if [[ "$distro_var" =~ ..Ubuntu ]]; then
cd ~
sudo apt-get install openssh-server
sudo service ssh start
service ssh status | grep active
read
clear

elif [[ "$distro_var" =~ CentOS.. ]]; then
sudo yum install openssh-server
sudo service ssh start
service ssh status | grep active

elif [[ "$distro_var" =~ openSUSE ]]; then
sudo zypper install openssh-server
sudo service ssh start
sudo service ssh status | grep active



else
echo "Sorry you will need to install ssh manually"
echo
echo
read
echo "Installtion may vary depending on distro."
exit
fi







##############################
#SSH setup function for Github
##############################

function git_ssh ()
{
 
	while [ -z "$select" ]
	do
		echo " We will now give you the option to install ssh if you do not already have it on your machine or generate your public key to connect with ssh and perform git clones via ssh for desired repos..


cd ~
cd .ssh









####################
# Distro Functions
####################
function debian_git ()

{


echo " Hit enter to install Github. This will install in the home directory."
read
cd ~
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




