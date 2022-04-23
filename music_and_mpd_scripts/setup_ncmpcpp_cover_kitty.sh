#! /usr/bin/env bash

#abre ncmpcpp no kitty com capa, autor: Gevane7881
#adaptado de:
##setup ncmpcpp on kitty with cover
##credits: https://github.com/kovidgoyal/kitty/issues/598#issuecomment-417895533

function launch_player() {
    # https://github.com/kovidgoyal/kitty/issues/598#issuecomment-417832346
    kitty @ set-tab-title music
    kitty @ set-window-title cover
    kitty @ new-window --title ncmpcpp ncmpcpp
    kitty @ resize-window --increment 93
    kitty @ new-window --title cava cava

    export PS1=""
    exec sh
}

function change_cover() {
   #kitty @ --to unix:/tmp/mykitty send-text \
   kitty @ send-text \
    --match title:cover \
    "clear && /usr/bin/kitty icat --transfer-mode=stream $HOME/.tmp/album-art/cover.png \r"
}

function extract_cover() {
  path="$1"
  border_color=#1fb1a4

  ffmpeg \
    -hide_banner \
    -loglevel 0 \
    -y \
    -i "$path" \
    -vf scale=400:-1 \
    -vf "scale=400:-1,pad=410:ow:(ow-iw)/2:(oh-ih)/2:${border_color}" \
    "$HOME/.tmp/album-art/cover.png" > /dev/null 2>&1
}

function replace_cover() {
    #MPD_MUSIC_PATH="/home/ge/music"
    #TMP_COVER_PATH="/tmp/cover.png"

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
    #echo "$pasta $album $artist $title"

    #procura arquivo na pasta de musicas
    arquivo=$(ls "$pasta" | grep -iwP "$artist" | grep -iwP "$title" | head -n 1)

    #se não encontrar tenta pelo album (subpasta)
    if [ -z "$arquivo" ]
    then

        pasta+="/"
        pasta+=$(ls "$pasta" | grep -iwP "$album")
        arquivo=$(ls "$pasta" | grep -iwP "$title" | head -n 1)
    fi

    #USE EXIFTOOL COMMAND TO EXTRACT IMAGE
    #img=$(exiftool -b -Picture "$pasta/$arquivo" > "$TMP_COVER_PATH")
    #adjust size
    #convert "$TMP_COVER_PATH" -resize 300x "$TMP_COVER_PATH"

    #music_dir="$HOME/Music/iTunes/iTunes Music/Music"
    temp_song="$HOME/.tmp/album-art/current-song"


    #cp "$music_dir/$(/usr/local/bin/mpc --format %file% current)" "$temp_song"
    cp "$pasta/$arquivo" "$temp_song" > /dev/null 2>&1

    #extract_cover "$temp_song/$arquivo" || cp "$HOME/.tmp/album-art/no-album-art.jpg" "$HOME/.tmp/album-art/cover.png"
    extract_cover "$temp_song" || cp "$HOME/.tmp/album-art/no-album-art.jpg" "$HOME/.tmp/album-art/cover.png"

    #rm "$temp_song/$arquivo"
    rm "$temp_song" > /dev/null 2>&1
}

if [[ $1 == "extract" ]]; then
  replace_cover
  change_cover
else
  launch_player
fi
