#!/bin/bash

#toca youtube no mpv, autor: Geovane7881
#recebe como argumento a url do vídeo

#url=$(xclip -o -sel clip)
url=$1

#------------------------------------------------------------
#youtube with mpv
youtube='youtube.com'
if [[ "$url" == *"$youtube"* ]]; then

nome=$(echo $url | xargs youtube-dl -e)

## displays a notif for 7s of the video being played
notify-send -t 7000 -i video-television \
"Playing $nome"

# plays the link in mpv
#umpv --fs `xclip -o -sel clip`

#removido arg pois buga saida do script umpv
#/home/ge/.scripts/umpv --fs $url
/home/ge/.scripts/umpv $url

fi





