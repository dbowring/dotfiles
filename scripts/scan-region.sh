#!/bin/bash

selection=$(slurp 2>/dev/null) || exit 0

mapfile -t raw_codes < <(grim -g "$selection" - | zbarimg --raw --quiet - 2>/dev/null)

declare -a codes
for code in "${raw_codes[@]}"; do
    trimmed="${code#"${code%%[![:space:]]*}"}"
    trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
    [[ -n "$trimmed" ]] && codes+=("$trimmed")
done

if [[ ${#codes[@]} -eq 0 ]]; then
    notify-send "QR Scanner" "No QR code detected"
else
    chosen=$(printf '%s\n' "${codes[@]}" | fuzzel --dmenu) || exit 0
    printf '%s' "$chosen" | wl-copy
fi
