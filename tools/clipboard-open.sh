#!/bin/bash

#SCRIPT TO HANDLE COPYIED LINKS ON CLIPBOARD by Geovane7881

#ainda em desenvolvimento por enquanto reproduz video do youtube no mpv (usa script umpv para gerar uma playlist)


url=$(xclip -o -sel clip)

#------------------------------------------------------------
#youtube with mpv
youtube='youtube.com'
if [[ "$url" == *"$youtube"* ]]; then

## displays a notif for 7s of the video being played
notify-send -t 7000 -i video-television \
"Playing" "`xclip -o -sel clip | xargs youtube-dl -e`"

# plays the link in mpv
umpv --fs `xclip -o -sel clip`

else
#------------------------------------------------------------
#image or other download
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

#filtro de imagens do google
#start="https://www.google.com/imgres?imgurl="
#end="&imgrefurl"
#começo
new_url=${url/#\https:\/\/www\.google\.com\/imgres\?imgurl=/}
##final
new_url=${new_url/%&imgrefurl*/}

file=$(urldecode $new_url)

#notificacao
notify-send -t 7000 -i video-television \
"Downloading:" "`echo $file | xargs basename`"

#baixa
wget $file -P /home/ge/down/

fi




