#!/bin/sh
#export PATH=$PATH:/usr/lib/surfraw
export PATH=$PATH:/home/ge/.config/surfraw/elvi
#export BROWSER=vivaldi-stable
#export BROWSER=qutebrowser

#entrada do rofi
pesquisa=$(sr -elvi | awk -F'-' '{print $1}' | sed '/:/d' | awk '{$1=$1};1' | rofi -width 90 -kb-row-select "Tab" -kb-row-tab "Control+space" -dmenu -mesg ">>> Tab = Autocomplete" -i -p "websearch: ")

#pega primeira coluna (buscador)
buscador=$(echo $pesquisa | cut -f 1 -d ' ')
#verifica se tem na lista de buscadores do surfraw
lista=$(sr -elvi | tail -n +2 | cut -f 1 -d '-')

isInLista=$(echo $lista | grep -c $buscador)

if [ $isInLista -eq 1 ]; then
    surfraw $pesquisa
else

    if [[ -n $pesquisa ]]; then
        #se não tiver usa o search padrão duckduckgo
        #surfraw duckduckgo $pesquisa
        surfraw d $pesquisa
    fi
fi
