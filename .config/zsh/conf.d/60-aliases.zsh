# https://github.com/eza-community/eza
if (command -v eza > /dev/null); then
    alias ls=eza
fi

# https://github.com/sharkdp/bat
if (command -v bat > /dev/null); then
    alias cat=bat
fi

if (command -v vopono > /dev/null); then
    alias withvpn='vopono exec --provider mullvad --server ${MULLVAD_SERVER_REGION:-usa}'
fi

if (command -v helix > /dev/null); then
    alias hx=helix
fi
