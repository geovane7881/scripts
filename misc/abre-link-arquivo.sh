#!/bin/bash

#script que pega um link qualquer do arquivo e abre no navegador
file='~/docs/lista_musicas.txt'

while : ; do
    #link=$(shuf $1 | head -n 1)
    link=$(shuf $file | head -n 1)
    if [[ $link == *"http"* ]]
    then
        #pegar dps do http
        link2=$( echo $link | grep -oP 'http.?://\S+')
        #vivaldi-stable --incognito $link2
        #sh ~/.scripts/qute_private.sh $link2
        chromium --incognito $link2
    fi
    [[ $link != *"http"* ]] || break
done
