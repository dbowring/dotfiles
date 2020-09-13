export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
#export XDG_RUNTIME_DIR=/run/user/$UID
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$XDG_DATA_HOME/zsh_history

export ZGEN_DIR=$XDG_DATA_HOME/zgen
export BULLETTRAIN_PROMPT_CHAR="λ"
export BULLETTRAIN_STATUS_EXIT_SHOW=true
export BULLETTRAIN_TIME_12HR=false
export BULLETTRAIN_PROMPT_ORDER=(
    time
    context
    dir
    virtualenv
    nvm
    rust
    git
    cmd_exec_time
    status
)

export EDITOR=$(command -v vim)
export VIMINIT='exe "source" "$XDG_CONFIG_HOME/vim/vimrc"'
