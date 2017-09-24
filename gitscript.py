#!/usr/bin/env python3
import getpass
from github import Github
import os
input("Welcome to the github setup script...Please press enter to proceed.")
yum = os.system('which yum')
apt-get == os.system('which apt-get')
if yum == "usr/bin/yum":
    os.system ('cd ~')
    os.system('sudo yum install update')
    os.system('sudo yum install git')
    os.system('cd Documents') 
    print("A folder named githubprojects will now be created in your documents directory")
    os.system('mkdir githubprojects')
githubUser = input("Please type in your username : ")
githubPassword = getpass.getpass("Please type password for your github account: ")
g = Github(githubUser, githubPassword)
for repo in g.get_user().get_repos():
    print (repo.name)
    repo.edit(has_wiki=False)