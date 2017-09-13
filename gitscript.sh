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
}
##############################
#SSH setup function for Github
##############################
function git_ssh ()
{
echo " Now we will create a folder named .ssh in your home directory and generate a public ssh key for ssh cloning from github to your local machine. "
read
clear
cd ~
cd .ssh
echo " Please hit enter multiple times as the key generating prompts are running. No need to enter a paraphrase it will generate one for you."
echo_spacer
ssh-keygen -t rsa
clear
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
sudo yum install git
elif [[ ! -z $APT_GET_CMD ]]; then
sudo apt-get install git
elif [[ ! -z $ZYPPER_CMD ]]; then
sudo zypper install git
elif [[ ! -z $PACMAN_CMD ]]; then
sudo pacman install git
else
echo "error cannot find distro..."
exit 1;
fi
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install git
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
git_ssh 



