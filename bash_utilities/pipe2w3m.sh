#!/bin/bash
cat "$@"| w3m -o auto_image=TRUE -I %{charset} -T text/html -F
