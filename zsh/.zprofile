uid=$(id -u)
runtime_dir="/run/user/$uid"

if [ ! -d "$runtime_dir" ] || [ "$(stat -c %u "$runtime_dir" 2>/dev/null)" != "$uid" ]; then
    doas sh -c 'mkdir -p "$1" && chown "$2:$3" "$1" && chmod 700 "$1"' sh \
        "$runtime_dir" "$uid" "$(id -g)"
fi

export XDG_RUNTIME_DIR="$runtime_dir"
export QT_QPA_PLATFORMTHEME=gtk3
export ELECTRON_OZONE_PLATFORM_HINT=auto
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XCURSOR_THEME=Bibata-Modern-Ice
export XCURSOR_SIZE=24
. "$HOME/.cargo/env"
