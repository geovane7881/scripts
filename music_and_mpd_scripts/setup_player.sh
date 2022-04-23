#!/bin/bash

#abre mpsyoutube (youtube cli), ncmpcpp (musica cli) e o cava (visualizador)

#hddub channel
mpsyt_query="mpsyt user HDdubRAVE3"

#chillnation
#mpsyt_query="mpsyt user ChillStepNation"

$TERMCMD --class ncmpcpp -e "ncmpcpp" &
sleep 0.500

$TERMCMD --class mpsyt -e $mpsyt_query &

#$TERMCMD --class cava -e cava &
#sleep 0.100



