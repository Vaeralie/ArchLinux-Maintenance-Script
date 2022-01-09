# Presentation
An all-in-one script that simplifies system maintenance on Arch Linux and Arch-based Linux distributions.

This script can :
1. check for failed systemd services,
2. check for errors in the logs files,
3. upgrade official packages,
4. upgrade AUR packages,
5. check for orphaned packages,
6. clean packages cache,
7. check disks health,

on demand by the user from the script's menu.

![Screenshot_2022-01-09_01-37-57](https://user-images.githubusercontent.com/84401519/148664681-52ff22e4-316f-4943-8853-d4191cd7eead.png)



# Requirements 

This tool requires [smartmontools](https://wiki.archlinux.org/title/S.M.A.R.T.) to be installed on the system for option 6. to work. If needed, the [smartmontools package](https://archlinux.org/packages/extra/x86_64/smartmontools/) can be directly installed just by selecting option 6.
