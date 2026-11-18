#!/bin/sh
used=$(swaymsg -t get_workspaces | jq '[.[].num]')
next=$(echo "$used" | jq 'first(range(1; 100) as $i | select(. | index($i) | not) | $i)')
swaymsg workspace number "$next"
