#!/bin/bash

## Script para reproduzir musicas do youtube (usado preferencialmente com o mps-youtube)
## adiciona a musica no server mopidy (mpd) e mostra no player ncmpcpp

#--------------------------------------------------------
#default vars

title=""
id=""
download=false
play=false

#--------------------------------------------------------
#pega argumentos

echo "invocation command: $@" >> ~/.scripts/music_log.txt

# saner programming env: these switches turn some bugs into errors
#set -o errexit -o pipefail -o noclobber -o nounset

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null 

OPTIONS=i:t:dp
LONGOPTS=id:,title:,download,play

! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -t|--title)
            title="$2"
            shift 2
            ;;
        -i|--id)
            id="$2"
            shift 2
            ;;
        -d|--download)
            #pra receber valor true
            #download="$2"
            #shift 2

            #assim é mais facil é só setar mandar a opção -d
            download=true
            shift 
            ;;
        -p|--play)
            play=true
            shift 
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

#link stream
musica=$1

if [ -z $id ]; then
    echo "por favor inserir o id/link do vídeo"
    exit
fi

#--------------------------------------------------------
#tratamento de titulo

#verifica titulo, se não tiver pega um 
if [ -z "$title" ]; then
    #title=$(youtube-dl --get-title "$id")
    echo 'nao tem titulo'
fi

#salva titulo original recebido
mps_title="$title"

#grab artist and title
artist="$(echo $title | cut -d '-' -f 1)"
title="$(echo $title | cut -d '-' -f 2)"

#filter for artist
#remove [HD] Electro House: prefix posso tbm excluir isso da string 
artist="$(echo $artist | cut -d ':' -f 2)"

#filters for title
# remove () things
title="$(echo $title | cut -f 1 -d '(')"
#remove [] things
title="$(echo $title | cut -f 1 -d '[')"

#trim whitespaces
#turn it on
shopt -s extglob
#title="    This is a test    "
### Trim leading whitespaces ###
title="${title##*( )}"
artist="${artist##*( )}"
### trim trailing whitespaces  ##
title="${title%%*( )}"
artist="${artist%%*( )}"
# turn it off
shopt -u extglob

echo "original title: $mps_title, parsed title: $artist - $title, ytid: $id" >> ~/.scripts/music_log.txt

#--------------------------------------------------------
#modo streaming, usando mopidy
if [ $download = false ]; then

    #reproduz agora
    if [ $play = true ]; then
        #adiciona como proxima
        mpc insert "yt:http://www.youtube.com/watch?v=$id"
        #ocultando saida
        mpc next > /dev/null && mpc play > /dev/null
    else
        #adiciona na playlist
        mpc add "yt:http://www.youtube.com/watch?v=$id"
    fi

    #mensagem melhor
    status=$(mpc status)
    #posição da musica atual (que ta tocando agora)
    atual_position_first=$(echo $status | awk -F'\\[playing\\]' '{print $2}' | cut -d '/' -f 1 | tr -dc '0-9')
    #posição da musica adicionada a playlist
    atual_position_second=$(echo $status | awk -F'\\[playing\\]' '{print $2}' | cut -d '/' -f 2 | cut -f 1 -d ' ')

    echo "--------------------------------------------------------"
    echo "Tocando: $artist - $title #$(($atual_position_first+1)) of $atual_position_second"
    echo "--------------------------------------------------------"

    if [ $play = false ]; then
        echo "--------------------------------------------------------"
        echo "Adicionado: $artist - $title #$atual_position_second"
        echo "--------------------------------------------------------"
    fi

#--------------------------------------------------------
#modo download and play:
else

    #verifica se tenho a música na pasta
    tem_musica=$(ls "/home/ge/music/downloaded/" | grep -i "$title" | grep -i "$artist")

    #se não tiver baixa
    if [ -z "$tem_musica" ]; then
        youtube-dl --audio-quality 0 -i --extract-audio --audio-format mp3 -o '/home/ge/music/downloaded/%(title)s.%(ext)s' --add-metadata --embed-thumbnail --metadata-from-title "%(artist)s - %(title)s" "$id"
    else
        echo "Arquivo já está na biblioteca de músicas"
    fi

    #adiciona arquivo baixado na playlist -p=true faz tocar automaticamente
    sh /home/ge/.scripts/mpc_add "$artist" "$title" $play

fi

#atualiza ncmpc
#killall ncmpcpp && bash -c ''"$TERMCMD"' -e ~/.scripts/lazyncmpc.sh' &

exit 0
