#!/usr/bin/env zsh

set -euo pipefail


assert_command_available() {
    if ! type $1 > /dev/null; then
        dotfiles_showmessage Missing \'$1\' command >&2
        exit 1
    fi
}

assert_font_available() {
    if ! (fc-list | grep $1 > /dev/null); then
        dotfiles_showmessage Missing font $1
        exit 1
    fi
}

check_optional_command() {
    if ! type $1 > /dev/null; then
        dotfiles_showmessage Missing optional extra \'$1\' >&2
    fi
}

dotfiles_showmessage() {
    echo DOTFILES: $@
}

dotfiles_copy_prompt() {
    indir=$1
    outdir=$2
    relative_path=$3

    inpath=$indir/$relative_path
    outpath=$outdir/$relative_path

    if [[ ! -f "$outpath" ]]; then
        dotfiles_showmessage new file: $relative_path
        # Using `cp -i` because I'm paranoid
        cp -i "$inpath" "$outpath"
    else
        if (diff --color -u --label existing/$relative_path --label new/$relative_path "$outpath" "$inpath"); then
            dotfiles_showmessage unchanged: $relative_path
        else
            dotfiles_showmessage modified: $relative_path
            cp -i "$inpath" "$outpath"
        fi
    fi
}

dotfiles_clone_or_pull() {
    name=$1
    url=$2
    gitdir=$3

    if [[ -d $gitdir ]]; then
        dotfiles_showmessage updating $name
        git -C $gitdir pull
    else
        dotfiles_showmessage installing $name
        mkdir -p "$gitdir"
        git clone $url $gitdir
    fi
}

dotfiles_zsh() {

    if [[ "$ZDOTDIR" != "$HOME/.config/zsh" ]]; then
        dotfiles_showmessage 'You need to set ZDOTDIR=$HOME/.config/zsh either in ~/.zshrc or /etc/zsh/zshenv'
        ZDOTDIR=$HOME/.config/zsh
    fi

    dotfiles_clone_or_pull zgen https://github.com/tarjoilija/zgen.git "$ZGEN_DIR"

    dotfiles_showmessage Copying zsh config to $ZDOTDIR

    srcdir="$SOURCE_DIR/zsh"

    if [[ ! -d "$ZDOTDIR" ]]; then
        mkdir -p $ZDOTDIR
        cp -a "$srcdir/." "$ZDOTDIR"
    else
        for p in $(find "$srcdir" -type f | sort); do
            rp=$(realpath --relative-to="$srcdir" "$p")
            outpath="$ZDOTDIR/$rp"
            outdir=$(dirname "$outpath")

            if [[ ! -d "$outdir" ]]; then
                mkdir -p "$outdir"
            fi

            dotfiles_copy_prompt "$srcdir" "$ZDOTDIR" "$rp"

        done
    fi
}

dotfiles_tmux() {

    if [[ -f "$HOME/.tmux.conf" ]]; then
        dotfiles_showmessage 'You must remove ~/.tmux.conf'
        dotfiles_showmessage If you want to keep it, move it to $XDG_CONFIG_HOME/tmux/tmux.conf
        exit 1
    fi

    tmux_conf_dir="$XDG_CONFIG_HOME/tmux"
    if [[ ! -d "$tmux_conf_dir" ]]; then
        mkdir -p "$tmux_conf_dir"
    fi

    dotfiles_showmessage Copying tmux config to $tmux_conf_dir
    dotfiles_copy_prompt "$SOURCE_DIR" "$tmux_conf_dir" tmux.conf
}

dotfiles_alacritty() {
    conf_dir="$HOME/.config/alacritty"

    if [[ ! -d "$conf_dir" ]]; then
        mkdir -p "$conf_dir"
    fi

    dotfiles_copy_prompt "$SOURCE_DIR" "$conf_dir" alacritty.yml

}

assert_command_available diff
assert_command_available dirname
assert_command_available find
assert_command_available realpath
assert_command_available git
assert_command_available tmux
assert_command_available alacritty
assert_command_available vim

check_optional_command exa
check_optional_command bat

assert_font_available 'Hack:style=Regular'


INSTALL_SCRIPT_PATH=$0:A
SOURCE_DIR=$(dirname $INSTALL_SCRIPT_PATH)
source "$SOURCE_DIR/zsh/.zshenv"

dotfiles_zsh
dotfiles_tmux
dotfiles_alacritty
dotfiles_showmessage Complete!
