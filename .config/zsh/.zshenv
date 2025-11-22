export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
#export XDG_RUNTIME_DIR=/run/user/$UID
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_STATE_HOME=$HOME/.local/state

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$XDG_DATA_HOME/zsh_history

export EDITOR=$(command -v helix)
export VIMINIT='exe "source" "$XDG_CONFIG_HOME/vim/vimrc"'

export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
path+=($CARGO_HOME/bin)

path+=($HOME/scripts)

export PATH

export WORDCHARS='!#$%&()*;<=>?[]^{}~'
