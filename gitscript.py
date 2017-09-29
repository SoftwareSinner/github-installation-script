#!/usr/bin/env python3
import getpass
from github import Github
import sys
import platform
import yum
import apt
#input("Welcome to the github setup script...Please press enter to proceed.")
debugValue = True

class CheckOS(object):
    def OSType(self):
        osType = platform.system()
        if debugValue: print ("Here is osType: ", osType)
        return osType
    def OSVersion(self, osType):
        self.osType = osType
        if osType == "Darwin":
            macVersion = platform.mac_ver()
            if debugValue: print ("Here is the macVersion: ", macVersion)
            return macVersion
        if osType == "Linux":
            linuxVersion = platform.linux_distribution()
            if debugValue: print ("Here is the linuxVersion: ", linuxVersion)
            return linuxVersion
        if osType == "Windows":
            print("Sorry, Windows is not supported")
osType = CheckOS().OSType()
OsVersion = CheckOS().OSVersion(osType)

if "ubuntu" in osversion or "debian" in osversion:
    print ("The package manager is apt-get")
if "suse" in osversion:
    print ("The package manage is zypper")
if "arch" in osversion:
    print ("The package manager is pacman")
if "fedora" in osversion:
    print ("The package manager is dnf")
if "centos" in osversion or "redhat" in osversion:
    print("The package manager is yum..")

    class YumCheck(object):
        def YumBase(self, yumpackage):
            self.yumpackage = yumpackage
            yb = yum.yumbase()
            if yb.rpmdb.searchnevra(name=yumpackage):
                print ("the package is installed", yumpackage)
            else:
                print ("the package not installed", yumpackage)

YumCheck().YumBase("openssh-server")
YumCheck().YumBase("git")
YumCheck().YumBase("jq")
