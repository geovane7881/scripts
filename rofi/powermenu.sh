#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi"
#rofi_command="rofi -font \"Fira Code 12\""

### Options ###
# power_off=""
# reboot=""
# lock=""
# suspend="鈴"
# log_out=""
suspend="Suspender"
power_off="Desligar"
reboot="Reiniciar"
lock="Bloquear"
log_out="Sair"
# Variable passed to rofi
options="$log_out\n$reboot\n$power_off"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $power_off)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        /usr/bin/i3exit lock
        ;;
    $suspend)
        ;;
    $log_out)
        awesome-client "awesome.quit()"
        ;;
esac

