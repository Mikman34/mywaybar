#!/bin/bash

PIDFILE="/tmp/wofi-power.pid"

# Toggle menu
if [[ -f "$PIDFILE" ]]; then
  pkill -F "$PIDFILE" && rm "$PIDFILE"
  exit
fi

(
CHOICE=$(wofi --style ~/.config/wofi/style.css \
  --location=3 --x-offset=-10 --y-offset=10 \
  --width=220 --height=200 \
  --dmenu -p "Power Menu" <<EOF
  Shutdown
󰜉  Reboot
  Suspend
  Lock
EOF
)

case "$CHOICE" in
  *Shutdown) systemctl poweroff ;;
  *Reboot) systemctl reboot ;;
  *Suspend) systemctl suspend ;;
  *Lock) gtklock ;;
esac
) & echo $! > "$PIDFILE" && disown
