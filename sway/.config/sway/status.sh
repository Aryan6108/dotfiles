#!/bin/bash

# Colors (same palette as the waybar style.css)
FG="#e8e8d3"
GRAY="#888888"
GREEN="#99ad6a"
BLUE="#8197bf"

exec 3<&0
{
  while read -r line <&3; do
    case "$line" in
    *'"name":"clock"'*)
      swaymsg kill >/dev/null 2>&1
      ;;
    *'"name":"volume"'*)
      case "$line" in
      *'"button":4'*) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 2%+ ;;
      *'"button":5'*) wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- ;;
      *'"button":1'*) pavucontrol >/dev/null 2>&1 & ;;
      esac
      ;;
    esac
  done
} &

# ---- modules ----
mem() {
  awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "RAM: %.2f GiB", (t-a)/1048576}' /proc/meminfo
}

vol() {
  local out v icon
  out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null) || {
    echo "󰝟 --"
    return
  }
  v=$(awk '{printf "%d", $2*100 + 0.5}' <<<"$out")
  if [[ $out == *MUTED* ]]; then
    echo "MUTED:󰝟 ${v}%"
  else
    if ((v < 34)); then
      icon="󰕿"
    elif ((v < 67)); then
      icon="󰖀"
    else
      icon="󰕾"
    fi
    echo "OK:${icon} ${v}%"
  fi
}

block() { # name color text
  printf '{"name":"%s","full_text":" %s ","color":"%s","separator":false,"separator_block_width":8}' "$1" "$3" "$2"
}

# ---- main loop ----
echo '{"version":1,"click_events":true}'
echo '['
echo '[]'
while true; do
  v=$(vol)
  vcolor=$BLUE
  [[ $v == MUTED:* ]] && vcolor=$GRAY
  vtext=${v#*:}

  echo ",[$(block memory "$GREEN" "$(mem)"),$(block volume "$vcolor" "$vtext"),$(block clock "$FG" "$(date '+%d %a - %I:%M')")]"
  sleep 1
done
