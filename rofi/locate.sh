#!/bin/sh

#locate /home/ge/Imagens /home/ge/Música /home/ge/Documentos /home/ge/Downloads /mnt/hd | rofi -threads 0 -width 100 -dmenu -i -p "locate:" | xargs -r -0 xdg-open

#xdg-open "$(find /home/ge/ -not -path '*/\.*' -type f | rofi -threads 0 -width 100 -dmenu -i -p "locate:")"

# xdg-open "$(find /mnt/hd/1\ -\ Biblioteca /home/ge/docs -not -path '*/\.*' -type f | rofi -threads 0 -columns 1 -width 90 -dmenu -i -p "locate:")"
xdg-open "$(find /home/geovane/Documentos/ '*/\.*' -type f | rofi -threads 0 -columns 1 -width 90 -dmenu -i -p "locate:")"
