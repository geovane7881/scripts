#! /usr/bin/env bash

#coloca a capa da musica no terminal kitty

kitty @ send-text \
  --match title:cover \
  "
    PS1='' bash --init-file <(echo '
      clear && \
        kitty icat --transfer-mode=stream /tmp/cover.png
    ') \r
  "
