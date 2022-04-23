#!/bin/bash

#script que aplica a capa de uma musica ao terminal kitty (usando mopidy como server mpd)

MPD_MUSIC_PATH="/home/ge/music"
#TMP_COVER_PATH="/tmp/cover.jpg"
TMP_COVER_PATH="/tmp/cover.png"

#procurar caminho absoluto
#saida do mpc
#$pasta="downloaded"
pasta="/home/ge/music/"
pasta+=$(mpc -f %file% current | cut -f1 -d/ | cut -f3 -d:)

artist=$(mpc -f %artist% current)
#filter for artist
#remove [HD] Electro House: prefix posso tbm excluir isso da string 
artist="$(echo $artist | cut -d ':' -f 2)"

album=$(mpc -f %album% current)
title=$(mpc -f %title% current)
echo "$pasta $album $artist $title"

#procura arquivo na pasta de musicas
arquivo=$(ls "$pasta" | grep -iwP "$artist" | grep -iwP "$title" | head -n 1)

#se não encontrar tenta pelo album
    if [ -z "$arquivo" ]
    then

        pasta+="/"
        pasta+=$(ls "$pasta" | grep -iwP "$album")
        arquivo=$(ls "$pasta" | grep -iwP "$title" | head -n 1)
    fi

  #USE EXIFTOOL COMMAND TO EXTRACT IMAGE
  #exiftool -b -Picture "$MPD_MUSIC_PATH/$(mpc -p 6600 --format "%file%" current)" > "$TMP_COVER_PATH"
  exiftool -b -Picture "$pasta/$arquivo" > "$TMP_COVER_PATH"

#MUSIC_DIR=$HOME/documents/music

COVER=/tmp/cover.png

function reset_background
{
    #printf "\e]20;;100x100+1000+1000\a"
    #printf '<ESC>_Ga=d<ESC>\'
    :
}

{
#    album="$(mpc --format %album% current)"
#    file="$(mpc --format %file% current)"
#    album_dir="${file%/*}"
#    [[ -z "$album_dir" ]] && exit 1
#    album_dir="$MUSIC_DIR/$album_dir"
#
#    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
#    src="$(echo -n "$covers" | head -n1)"
#    rm -f "$COVER" 
    #if [[ -n "$src" ]] ; then
        #resize the image's width to 300px 
        #convert "$src" -resize 300x "$COVER"
        convert "$TMP_COVER_PATH" -resize 300x "$COVER" > /dev/null
        if [[ -f "$COVER" ]] ; then
           #scale down the cover to 30% of the original
           #place it 1% away from left and 50% away from top.
           #printf "\e]20;${COVER};30x30+1+50:op=keep-aspect\a"

           reset_background
            python ~/.scripts/image_kitty.py "$TMP_COVER_PATH"
            
        else
           reset_background
            
        fi
    #else
    #    reset_background
    #fi
} &
