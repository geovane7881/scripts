#!/bin/bash

#script para bkp de dotfiles importantes que eu uso, se eu não usar mais romover da lista. Autor: Geovane7881

#------------------------------------------------------
# pastas para bkp
#------------------------------------------------------

origem="/home/ge"
destino="$origem/dotfiles"

#------------------------------------------------------
# limpa arquivos antigos
#------------------------------------------------------
rm -rv $destino/*

#------------------------------------------------------
# salva lista de pacotes do sistema
#------------------------------------------------------

# pacotes
sudo pacman -Qqen > "$origem/.packages/pkglist-repo.txt"
# pacotes aur
sudo pacman -Qqem > "$origem/.packages/pkglist-aur.txt"
# pacotes pip
pip list --format freeze > "$origem/.packages/pip3.txt"

#------------------------------------------------------
# configs da pasta home
#------------------------------------------------------

# instruções e script de instalação e bkp
mkdir -p "$destino/instrucoes"
cp -rv "$origem/.instrucoes" "$destino/instrucoes"

mkdir -p "$destino/X"
cp -rv "$origem/.xdrdb" "$destino/X"
cp -rv "$origem/.Xresources" "$destino/X"

# packages
cp -rv "$origem/.packages" "$destino/packages"

# diretorios do usuário
mkdir -p "$destino/XDG"
cp -rv "$origem/.config/user-dirs.dirs" "$destino/XDG/.config"

# misc
mkdir -p "$destino/misc"
cp -rv "$origem/.wallpaper" "$destino/misc/.wallpaper"

#wine
mkdir -p "$destino/wine"
cp -rv "$origem/.wine/user.reg" "$destino/wine/.wine"
cp -rv "$origem/.wine/userdef.reg" "$destino/wine/.wine"

# zsh
mkdir -p "$destino/zsh/.config"
cp "$origem/.zshrc" "$destino/zsh/"
cp "$origem/.zprofile" "$destino/zsh/"
cp "$origem/.config/aliasrc" "$destino/zsh/.config/"
cp "$origem/.config/functionsrc" "$destino/zsh/.config/"

# gtk
mkdir -p "$destino/gtk"
cp "$origem/.gtk-bookmarks" "$destino/gtk/"
cp "$origem/.gtkrc-2.0" "$destino/gtk/"
cp -rv "$origem/.config/gtk-2.0/" "$destino/gtk/.config"
cp -rv "$origem/.config/gtk-3.0/" "$destino/gtk/.config"

#------------------------------------------------------

# i3-scrot
mkdir -p "$destino/i3-scrot/.config"
cp "$origem/.config/i3-scrot.conf" "$destino/i3-scrot/.config"

# scripts
mkdir -p "$destino/scripts"
cp -rv "$origem/.scripts" "$destino/scripts/.scripts"

#------------------------------------------------------
# configs da pasta .config
#----------------------------------------------

declare -a pasta_config

pasta_config=(
    "autostart-scripts"
    "cava"
    "compton"
    "dunst"
    "youtube-dl"
    "surfraw"
    "lf"
    "nvim"
    "mutt"
    "newsboat"
    "mpv"
    "ncmpcpp"
    "mpd"
    "mopidy"
    "mps-youtube"
    "nautilus"
    "neofetch"
    "nitrogen"
    "transmission"
    "youtube-dl"
    "rofi"
    "polybar"
    
)

for name in "${pasta_config[@]}"
do
    mkdir -p "$destino/${name}/.config"
    cp -rv "$origem/.config/${name}" "$destino/${name}/.config/${name}"
done

#------------------------------------------------------
# configs kde
#----------------------------------------------

declare -a pasta_config_kde

pasta_config_kde=(
    #Panel
    "plasma-org.kde.plasma.desktop-appletsrc"

    ##Appearance
    #Global Theme
    "kdeglobals"
    "kscreenlockerrc"
    "kwinrc"
    "gtkrc"
    "gtkrc-2.0"
    #Plasma Style
    "plasmarc"
    #Application Style
    "kdeglobals"
    #Window Decorations
    "kwinrc"
    #Colors
    "kdeglobals"
    "Trolltech.conf"
    #Fonts
    "kdeglobals"
    "kcmfonts"
    #Icons
    "kdeglobals [Icons]"
    #Cursors
    "kcminputrc"

    ##Desktop behavior
    #General behavior
    "plasmarc"
    #Screen Edges
    "kwinrc"
    #Desktop Effects
    "kwinrc"
    "kglobalshortcutsrc"
    #Window Management
    #Window behavior
    "kwnirc"
    #Window Rules
    "kwinrulesrc"

    ##Shortcuts
    #Custom Shortcuts
    "khotkeys"
    #Global Shortcuts
    "kglobalshortcutsrc"

    ##System
    #Background Services
    "kded5rc"
    #Desktop Session
    "ksmserverrc"
    #Plasma Search
    "krunnerrc"
    #File Search
    "baloofilerc"
    #Notifications
    "plasmanotifyrc"
    #Regional Settings
    "plasma-localerc"
    #Date & Time
    "ktimezonedrc"
    #Accessibility
    "kaccessrc"
    #Default Applications
    "kdeglobals"
    #Bluetooth
    "bluedevilglobalrc"
    #Input Devices
    "kcminputrc"
    "kxkbrc"
    #Power Management
    "powermanagementprofilesrc"
    #KDE Connect
    "kdeconnect "
)

for name in "${pasta_config_kde[@]}"
do
    mkdir -p "$destino/kde/.config"
    cp -rv "$origem/.config/${name}" "$destino/kde/.config/${name}"
done

#------------------------------------------------------
# configs outras pastas
#------------------------------------------------------

# fontes
mkdir -p "$destino/fonts/.fonts"
cp -rv "/usr/share/fonts/ttf" "$destino/fonts/.fonts"

# variaveis de ambiente
mkdir -p "$destino/variaveis-ambiente"
sudo cp "/etc/environment" "$destino/variaveis-ambiente/"
cp "$origem/.profile" "$destino/variaveis-ambiente/"

#----------------------------------------------
# git push
#----------------------------------------------

cd $destino
git add *
git commit -m 'updated by script'
git push origin master

echo
echo "Dotfiles updated!"

#----------------------------------------------


