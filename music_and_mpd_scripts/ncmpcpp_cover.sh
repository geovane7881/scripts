#! /usr/bin/env bash

#Abre ncmpcpp com Capa da musica (funciona apenas no terminal kitty)

kitty @ set-tab-title music
kitty @ set-window-title cover
kitty @ new-window --title ncmpcpp ncmpcpp
kitty @ resize-window --increment 93
source "$HOME/.scripts/set-current-cover.sh"
