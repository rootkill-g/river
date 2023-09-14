choice=$(printf "Lock\nLogout\nSuspend\nReboot\nShutdown" | wofi --dmenu)
if [[ $choice == "Lock" ]] ; then
  waylock -init-color 0x000000 -input-color 0x1d1f21 -fail-color 0xcc342b
elif [[ $choice == "Logout" ]] ; then
  pkill -KILL -u "$USER"
elif [[ $choice == "Suspend" ]] ; then
  systemctl suspend
elif [[ $choice == "Reboot" ]] ; then
  systemctl reboot
elif [[ $choice == "Shutdown" ]] ; then
  systemctl poweroff
fi
