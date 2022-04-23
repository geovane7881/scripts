#!/bin/bash

#setup conky na config flattastic
#source: https://www.deviantart.com/nale12/art/Flattastic-Conky-425379608

#sleep 20
conky -D -c ~/.conky/conky-weather/conkyrc_weather &
conky -D -c ~/.conky/conky-calendar/conkyrc_google_calendar &
#conky -D -c ~/.conky/conky-calendar/conkyrc_calendar &
#conky -D -c ~/.conky/conky-ring/conkyrc_ring &
#conky -D -c ~/.conky/conky-rss/conkyrc_rss_archlinux &
#conky -D -c ~/.conky/conky-dash/conkyrc_dash_archlinux
exit 0
