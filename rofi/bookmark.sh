#!/bin/sh
export PATH=$PATH:/usr/lib/surfraw
#export BROWSER=chromium-browser
#export BROWSER=vivaldi-stable
#export BROWSER=qutebrowser

#surfraw -browser=$BROWSER "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sed '/^#/d' | sed '/^\//d' | sort -n | rofi -color-window "#000000, #000000, #000000" -color-normal "#000000, #b3e774, #000000, #b3e774, #000000" -color-active "#000000, #b3e774, #000000, #b3e774, #000000" -color-urgent "#000000, #b3e774, #000000, #b3e774, #000000" -dmenu -mesg ">>> Edit to add new bookmarks at ~/.config/surfraw/bookmarks" -i -p "bookmarks: ")"

surfraw -browser=$BROWSER "$(cat ~/.config/surfraw/bookmarks | sed '/^$/d' | sed '/^#/d' | sed '/^\//d' | sort -n | rofi -columns 1 -width 90 -dmenu -mesg ">>> Edit to add new bookmarks at ~/.config/surfraw/bookmarks" -i -p "bookmarks: ")"
