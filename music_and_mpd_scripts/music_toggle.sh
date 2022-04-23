#!/bin/bash

#pausa/reproduz musica (toggle)
#usando mopidy como server mpd
#autor: Geovane7881

mpc toggle
tocando=$(echo $(mpc status ) | grep -i "playing")

#se não tiver tocando mostra status (util quando o sistema não notifica)
if [ -z "$tocando" ]; then
    sleep 0.5
    notify-send "$(mpc status)"
else
    ~/.scripts/music_notify.py
fi
