#!/bin/bash

#locate /home/geovane/Imagens /home/geovane/Música /home/geovane/Documentos /home/geovane/Downloads /media/hd | rofi -threads 0 -width 100 -dmenu -i -p "locate:" | xargs -r -0 xdg-open

#xdg-open "$(find /mnt/hd/estudo/notes/ *.txt | rofi -threads 0 -width 100 -dmenu -i -p "locate:")"
#urxvt -e nvim "$(find /mnt/hd/estudo/notes/ *.txt | rofi -threads 0  -columns 1 -width 90 -dmenu -i -p "locate:")"
#file=")

#termite
#termite -c ~/.cache/wal/termite -e "nvim $(find /mnt/hd/estudo/notes/ *.txt | rofi -threads 0  -columns 1 -width 90 -dmenu -i -p "locate:")"


#preciso de um tratamento pra tirar esse espaço do 2 - Notes
file=$(find "/home/geovane/Documentos/notes/" *.txt | rofi -threads 0  -columns 1 -width 90 -dmenu -i -p "locate:")

# setar e usar 
#$TERMCMD
echo $file

if [[ -n $file ]]; then
    kitty --class nvim -e nvim "$file"
fi
