sleep 2 && find "${XDG_RUNTIME_DIR}" -name 'sway-ipc.*.*.sock' -exec swaymsg -s {} output '*' enable dpms on \;

