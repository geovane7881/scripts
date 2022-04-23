#!/bin/bash

#abre qutebrowser com campo de pesquisa na tela (rofi)

if pgrep -x "qutebrowser" >/dev/null
then
    #se tiver aberto só abrir o popup
    qutebrowser ":spawn --userscript ~/.scripts/qutebrowser/dmenu-open --tab" 
else
    #se nao tiver aberto abrir
    qutebrowser & sleep 0.2
    #qutebrowser ":open about:blank ;; spawn --userscript ~/.scripts/qutebrowser/dmenu-open" 
    qutebrowser ":spawn --userscript ~/.scripts/qutebrowser/dmenu-open" 
fi
