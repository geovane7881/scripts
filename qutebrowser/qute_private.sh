#!/bin/bash

#abre link no qutebrowser no modo anonimo, autor: Geovane7881

#qutebrowser &
#sleep 0.250;
link=$1

#if ps ax | grep -v grep | grep qutebrowser > /dev/null
#then
#    #se o navegador tiver aberto não fechar
#    qutebrowser ":open -p $link"
#else
#    #fecha janela extra
#    qutebrowser ":open -p $link ;; close"
#fi
#

#melhor fechar tudo mesmo
#abre uma janela privada e fecha a anterior
#só dar um control n e dps um meta + f10 se ja tiver aberto

if pgrep -x "qutebrowser" >/dev/null
then
    #se tiver aberto
    qutebrowser ":open -p $link"
else
    #se nao tiver aberto abrir nova janela
    qutebrowser ":open -p $link ;; close"
fi
