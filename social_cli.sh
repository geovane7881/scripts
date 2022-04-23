#!/bin/bash

# Social Network CLI Setup
# Opens newsboat (feed), neomutt (email) and finch (facebook)
#


$TERMCMD --name newsboat -e newsboat &
sleep 0.100
$TERMCMD --name neomutt -e neomutt &
sleep 0.100
$TERMCMD --name finch -e finch &

