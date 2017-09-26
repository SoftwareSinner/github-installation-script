#!/usr/bin/env python3
import getpass
from github import Github
import os
import sys
input("Welcome to the github setup script...Please press enter to proceed.")
def yum_func():
    yum = os.system('which yum')
    if yum == 0:
    os.system('cd ~')
    os.system('sudo yum install update')
    print("Installing Github on your machine..")
    os.system('sudo yum install git')
    os.system('sudo yum -y groupinstall development')
    os.system('sudo yum -y install zlib-devel')
    os.system('sudo wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz')
    os.system('tar xJf Python-3.6.0.tar.xz')
    os.system('cd Python-3.6.0')
    os.system('./configure')
    os.system('make')
    os.system('make install')
    os.system('clear')
    print("Python is now on your system!")
    os.system('python3 -V')
    print("SSH will now be installed.")
    os.system('sudo yum install openssh-server')
    os.system('sudo systemctl enable sshd.service')
    os.system('sudo systemctl status sshd.service | grep active')
    os.system('sudo yum install jq')
    print("A folder named githubprojects will now be created in your documents directory")
    os.system('cd Documents')
    os.system('mkdir githubprojects')
def deb_func():
    apt-get = os.system('which apt-get')
    if apt-get == 0:
    os.system('sudo apt-get install python3.6')
    os.system('sudo apt-get install python-pip')
    print("SSH will now be installed..")
    os.system('sudo apt-get install openssh-server')
    os.system('sudo service ssh start')
    os.system('sudo service ssh status | grep active')
    os.system('sudo apt-get update')
    print("Installing Github")
    os.system('sudo apt-get install git') 
    os.system('sudo apt-get install jq')
def zypper_func():
    
def git_ssh():
    print("SSH key is now being created..")
    os.system('ssh-keygen -t rsa') 
    os.system('KEY=$(sudo cat ~/.ssh/id_rsa.pub)')
    os.system('echo "Here is your KEY var: ${KEY}"')
    os.system('clear')
    os.system('read -p "GitHub Username: " USERNAME')
    os.system('read -p "Please enter a title for you ssh key: " TITLE')
    os.system('jq -n --arg t "$TITLE" --arg k "$KEY" '{title: $t, key: $k}' | curl --user "$USERNAME" -X POST --data @- https://api.github.com/user/keys'
def git_auth(gitauth):
    githubUser = input("Please type in your username : ")
    githubPassword = getpass.getpass("Please type password for your github account: ")
    g = Github(githubUser, githubPassword)
    for repo in g.get_user().get_repos():
    print (repo.name)
    repo.edit(has_wiki=False)
