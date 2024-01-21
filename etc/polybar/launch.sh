#!/usr/bin/env bash
polybar-msg cmd quit
polybar lower_bar 2>&1 | tee -a /tmp/polybar.log & disown
echo "Bars launched..."
