#!/usr/bin/env python
"""
Get a notification summary and body from mpc, then send it through dbus.
https://developer.gnome.org/notification-spec/#protocol
"""

from subprocess import check_output
from dbus import SessionBus, Interface

mpc = check_output("mpc --format='%album%\n%artist%\t%title%'", shell=True)\
                   .decode("utf-8")
try:
    summary, body = mpc.splitlines()[:2]
except ValueError:
    exit(127)

bus = {
    "path": "/org/freedesktop/Notifications",
    "name": "org.freedesktop.Notifications"
}

notif_args = [
    "ncmpcpp",          # app_name
    227788,             # replaces_id
    "audio-x-generic",  # app_icon
    summary,            # summary
    body.translate(body.maketrans("\t", "\n")),    # body
    [],                                            # actions
    {"bgcolor": "#222222", "fgcolor": "#888888"},  # hints
    5000                                           # expire_timeout
]

proxy = SessionBus().get_object(bus["name"], bus["path"])
interface = Interface(proxy, bus["name"])
interface.Notify(*notif_args)
