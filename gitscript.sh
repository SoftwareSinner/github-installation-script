#!/bin/bash


OS_var=$(uname)
distro_var=$(cat /etc/*-release | head -n1)


#######################
#ssh download function
#######################
function ssh_download ()

{




cd ~
sudo apt-get install openssh-server







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

echo " A folder named github will now be created in the Documents directory. It is recommended to use this folder to organize all your github projects and git clones. Hit enter to continue.."
read
cd Documents 
mkdir github











#####################
#
#####################




while [ -z "$choice" ]
do


echo " Please your distro that you wish to install Github on.. "

       echo " 1 ~Debian-based~ "
            " 2 ~RedHat-based~ "
	    " 3 ~OpenSuse-based~ "
	    " 4 ~Arch-based~ "




read -r choice;

done

case $choice in
	1) 




