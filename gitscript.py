#!/usr/bin/env python3
import getpass
from github import Github
import os
input("Welcome to the github setup script...Please press enter to proceed.")
yum = os.system('which yum')
#apt-get == os.system('which apt-get')
if yum == 0:
    os.system('cd ~')
    os.system('sudo yum install update')
    os.system('sudo yum install git')
    os.system('yum -y groupinstall development')
    os.system('yum -y install zlib-devel')
    os.system('wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz')
    os.system('tar xJf Python-3.6.0.tar.xz')
    os.system('cd Python-3.6.0')
    os.system('./configure')
    os.system('make')
    os.system('make install')
    os.system('clear')
    print("Python is now on your system")
    os.system('python3 -V')
    print("A folder named githubprojects will now be created in your documents directory")
    os.system('cd Documents')
    os.system('mkdir githubprojects')
githubUser = input("Please type in your username : ")
githubPassword = getpass.getpass("Please type password for your github account: ")
g = Github(githubUser, githubPassword)
for repo in g.get_user().get_repos():
    print (repo.name)
    repo.edit(has_wiki=False)