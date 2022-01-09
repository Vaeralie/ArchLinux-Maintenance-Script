# Presentation
An all-in-one script that simplifies system maintenance on Arch Linux and Arch-based Linux distributions.

This script can :
1. check for failed systemd services,
2. check for errors in the logs files,
3. upgrade packages,
4. check for orphaned packages,
5. clean packages cache,
6. check disks health,

on demand by the user from the script's menu. The user is then guided through the process.

![Screenshot_2022-01-09_01-37-57](https://user-images.githubusercontent.com/84401519/148664681-52ff22e4-316f-4943-8853-d4191cd7eead.png)



# Requirements 

This tool requires [smartmontools](https://wiki.archlinux.org/title/S.M.A.R.T.) to be installed on the system for option 6. to work. If needed, the [smartmontools package](https://archlinux.org/packages/extra/x86_64/smartmontools/) can be directly installed just by selecting option 6.
