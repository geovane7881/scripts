#!/bin/bash

#Script instala bkp feito com dot-bkp.sh, autor: Geovane7881

#----------------------------------------------
# 1 - instalar atualizações
#----------------------------------------------

sudo pacman -Syyu

#----------------------------------------------
# 1 - git stow pra criar symlinks dos arquivos desse repositorio
#----------------------------------------------

sudo pacman -S stow
cd ~/dotfiles
stow -R *

#----------------------------------------------
# 2 - instalar pacotes
#----------------------------------------------

#pacotes
sudo pacman -S --needed --noconfirm $(< ~/pkglist-repo.txt)

#pacotes aur
#yay -S --needed --noconfirm $(< ~/pkglist-aur.txt)
yay -S --needed --noconfirm $(cat ~/pkglist-aur.txt | sed '/vivaldi-ffmpeg-codecs/d')

#pacotes pip
sudo pip3 install -r ~/pip3.txt

#----------------------------------------------
# 3 - mpsyt modificado, pra aceitar meu script de player
#----------------------------------------------

sudo cp -Trv ~/dotfiles/custom_programs/mps-youtube-modificado /usr/lib/python3.7/site-packages/mps_youtube

#---------------------------------------------------------------------
# 4 - mudar shell para bash
#---------------------------------------------------------------------

sudo pacman -S bash
chsh -s /bin/bash

#---------------------------------------------------------------------
# 5 - variaveis de ambiente, $TERMCMD etc
#---------------------------------------------------------------------

sudo cp ~/dotfiles/variaveis-ambiente/environment /etc/environment

#---------------------------------------------------------------------
# 6 - cores com wpgtk
#---------------------------------------------------------------------

###instalar icones e tema gtk:
wpg-install.sh -gi
###adicionar tema sunset:
wpg -a ~/dotfiles/misc/.wallpaper/sunset.jpg
###selecionar tema sunset:
wpg -s sunset.jpg

#---------------------------------------------------------------------
# 7 - configurando nvim
#---------------------------------------------------------------------


#---------------------------------------------------------------------
## 7.1 instalar vim-plug:

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#---------------------------------------------------------------------
## 7.2 instalar dependencia dos plugins:

#---------------------------------------------------------------------
### 7.2.1 - plugin vim-easytags (https://github.com/xolox/vim-easytags):

###baixar e compilar ctags5.8 com os comandos abaixo:

cd ~/Downloads
curl -O https://ufpr.dl.sourceforge.net/project/ctags/ctags/5.8/ctags-5.8.tar.gz
tar -xzf ctags-5.8.tar.gz
cd ctags-5.8
./configure
make
sudo make install

#---------------------------------------------------------------------
### 7.1.2 - plugin phpactor (https://phpactor.github.io/phpactor/vim-plugin.html):

###instalar modulos php necessários:

sudo pacman -S php-intl

echo "Por favor descomentar a extensão intl"
read -p "Press Enter to continue" </dev/tty

###procurar intl e descomentar
sudo vi /etc/php/php.ini


### instalar os plugins do nvim
#:PlugInstall
nvim -c ":PlugInstall"

### terminar instalação do phpactor
cd ~/.vim/plugged/phpactor
composer install









