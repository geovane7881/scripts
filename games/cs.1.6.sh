#!/bin/bash

export LD_LIBRARY_PATH=/usr/lib32/alsa-lib/
export MESA_GL_VERSION_OVERRIDE=4.5
export MANGOHUD=1
export WINEPREFIX=/home/ge/.wine
export vblank_mode=0
#wine hl.exe -game cstrike -gl -nomsaa -nofbo besides -noforcemparms -noforcemaccel -noforcemspd -freq 60
#wine hl.exe -steam -game cstrike -gl -nomsaa -nofbo besides -noforcemparms -noforcemaccel -noforcemspd -nojoy -nocrashdialog 32bpp -freq 60
#wine hl.exe  -steam -game cstrike -noforcemparms -noforcemaccel -nojoy -nocrashdialog -16bpp -freq 60 -nomsaa -nofbo -noaafonts -nosync -r_dynamic 0

wine hl.exe -steam -game cstrike -noforcemparms -noforcemaccel -nojoy -nocrashdialog -16bpp -freq 60 -nomsaa -nofbo -noaafonts -nosync -r_dynamic 0 -w 640 -refresh 60 -noforcemspd -gl
