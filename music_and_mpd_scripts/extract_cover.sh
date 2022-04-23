#!/bin/bash

#Script que extrai a capa com base nos metadados do arquivo de audio (usando exiftool)
#ao final coloca a capa no terminal do kitty

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

convert "$TMP_COVER_PATH" -resize 300x "$TMP_COVER_PATH" > /dev/null

source "$HOME/.scripts/set-current-cover.sh"
