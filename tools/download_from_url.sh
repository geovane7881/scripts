#!/bin/bash


#SCRIPT TO DOWNLOAD LINKS FROM URL by: Geovane7881


#url=$(xclip -o -sel clip)
url=$1

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





