#!/bin/bash

  ############## Menu ##############

  while true; do

  echo -e "\n"
  echo "Maintenance menu"
  echo "Select an option :"
  select MenuChoice in "Check for failed systemd services" "Check for errors in the log files" "Upgrade official packages" "Upgrade AUR packages" "Check for orphaned packages" "Clean packages cache" "Check disks health" "Reboot computer" "Exit program"; do
    case $MenuChoice in


    ############## Systemd services check ##############

    "Check for failed systemd services" ) echo -e "\n"
    echo "Checking for failed systemd services."
    echo "If needed, press Q to exit."
    echo -e "\n"
    systemctl --failed
    break;;


    ############## Error check ##############

    "Check for errors in the log files" ) echo -e "\n"
    echo "Checking for errors."
    echo "If needed, press Q to exit."
    echo -e "\n"
    journalctl -p 3 -b
    break;;


    ############## Official packages upgrade ##############

    "Upgrade official packages" ) echo -e "\n"
    echo "Upgrading official packages."
    pacman -Syu
    break;;


    ############## AUR packages upgrade ##############

    "Upgrade AUR packages" ) echo -e "\n"
    if pacman -Qs yay | grep -q 'yay'; then
        if [ "$EUID" = 0 ]; then
            echo "Please don't run this option as root nor sudo."
            else
            yay -Sua
        fi
    else
        echo "This option uses 'Yet another yogurt' (yay) to upgrade your AUR packages."
        echo "The yay package can be found in the AUR repository at the following link : https://aur.archlinux.org/packages/yay/"
    fi
    break;;


    ############## Orphaned packages check ##############

    "Check for orphaned packages" ) echo -e "\n"
    echo "Orphaned packages :"
    pacman -Qtd
    output="$(pacman -Qtd)"
        if [[ -n $output ]]; then
            echo -e "\n"
            echo "Remove orphaned packages ?"
            select yn in "Yes" "No"; do
                case $yn in
                    Yes ) pacman -Qtdq | pacman -Rns -; break;;
                    No ) break;;
                esac
            done
        else
            echo "No orphaned packages found."
        fi
    break;;


    ############## Packages cache cleaning ##############

    "Clean packages cache" ) echo -e "\n"
            echo "Clean cache of all packages or limit to uninstalled packages ?"
            select CleanType in "All" "Uninstalled"; do
                    echo "Enter the number of the most recent cached versions you want to keep :"
                    read -r VersionNumber
                        case $CleanType in
                            All ) paccache -rk"$VersionNumber"; break;;
                            Uninstalled ) paccache -ruk"$VersionNumber"; break;;
                        esac
            done
    break;;


    ############## Disks health checking ##############

    "Check disks health" )
        if pacman -Qs smartmontools | grep -q 'smartmontools'; then
            while true; do
            echo -e "\n"
            echo "Test disks health or check disks health ?"
            select DiskHealthChoice in "Test disks" "Check disks" "Return to main menu"; do
                  case $DiskHealthChoice in


                    "Test disks" ) while true; do
                    echo -e "\n"
                    echo "Enter the last letter of the disk you want to test (example : b for /dev/sdb) :"
                    read -r DiskLetter
                    while true; do
                    echo -e "\n"
                    echo "Select test length :"
                    select TestLength in "Short" "Long" "Check tests time"; do
                        case $TestLength in

                            Short ) smartctl -t short /dev/sd"$DiskLetter"
                            echo -e "\n"
                            echo "Test another disk ?"
                            select yn in "Yes" "No"; do
                                case $yn in
                                    "Yes" ) break 3;;
                                    "No" ) break 5;;

                                esac
                            done;;

                            Long ) smarctl -t long /dev/sd"$DiskLetter";
                            echo -e "\n"
                            echo "Test another disk ?"
                            select yn in "Yes" "No"; do
                                case $yn in
                                    "Yes" ) break 3;;
                                    "No" ) break 5;;

                                esac

                            done;;

                            "Check tests time" )
                            echo -e "\n"
                            smartctl -c /dev/sd"$DiskLetter" | grep -i 'recommended' | sed '1 i\ Short self-test routine for /dev/sd'"$DiskLetter"'' | sed '3 i\ Extended (long) self-test routine for /dev/sd'"$DiskLetter"''; break;;

                        esac
                    done
                    done
                    done;;


                    "Check disks" ) while true; do
                    echo -e "\n"
                    echo "Enter the last letter of the disk you want to check (example : b for /dev/sdb) :"
                    read -r DiskLetter
                    echo -e "\n"
                    smartctl /dev/sd"$DiskLetter" -HA
                    echo -e "\n"
                    echo "Check another disk ?"
                    select yn in "Yes" "No"; do
                                case $yn in
                                    "Yes" ) break;;
                                    "No" ) break 3;;
                                esac
                    done
                    done;;

            "Return to main menu" ) break 2;;

            esac
            done
            done

        else echo -e "\n"
        echo "This option requires smartmontools installed on your system."
        echo "Install smartmontools package now ?"
        select yn in "Yes" "No"; do
            case $yn in

            Yes ) pacman -S smartmontools; break;;
            No ) break;;

            esac
        done

    fi
    break;;


    ############## Reboot computer ##############

    "Reboot computer" ) reboot;;


############## Exit ##############

    "Exit program" ) exit;;


    ############## Menu closing ##############

  esac
  done
  done
  
