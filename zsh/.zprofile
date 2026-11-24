# ~/.zprofile

# Wayland / session
export ELECTRON_OZONE_PLATFORM_HINT=auto
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export QT_QPA_PLATFORMTHEME=lxqt
export QT_QPA_PLATFORM="wayland;xcb"

# Cursor
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_SIZE=24

# Rust
. "$HOME/.cargo/env"

# Auto-start sway on tty1
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec dbus-run-session -- sway
fi
