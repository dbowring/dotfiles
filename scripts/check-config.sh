#!/bin/zsh

if [[ "$ZDOTDIR" != "$HOME/.config/zsh" ]]; then
  echo >&2 'You need to set ZDOTDIR=$HOME/.config/zsh either in ~/.zshrc or /etc/zsh/zshenv'
fi

if [[ -f "$HOME/.tmux.conf" ]]; then
    echo >&2 'You must remove ~/.tmux.conf'
    echo >&2 if you want to keep it, move it to $XDG_CONFIG_HOME/tmux/tmux.conf
fi

if [[ -f "$HOME/.vimrc" ]]; then
    echo >&2 'You must remove ~/.vimrc'
    echo >&2 If you want to keep it, move it to $XDG_CONFIG_HOME/vim/vimrc
    exit 1
fi

