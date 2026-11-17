#!/bin/sh
n=$(swaymsg -t get_workspaces | jq length)
swaymsg workspace number $((n + 1))
