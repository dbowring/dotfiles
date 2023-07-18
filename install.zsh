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
        cp -i "$inpath" "$outpath" || true
    else
        if (diff --color -u --label existing/$relative_path --label new/$relative_path "$outpath" "$inpath"); then
            dotfiles_showmessage unchanged: $relative_path
        else
            dotfiles_showmessage modified: $relative_path
            cp -i "$inpath" "$outpath" || true
        fi
    fi
}

dotfiles_copy_dir_prompt() {
    indir=$1
    outdir=$2

    if [[ ! -d "$outdir" ]]; then
        mkdir -p $outdir
        cp -a "$indir/." "$outdir"
    else
        for p in $(find "$indir" -type f | sort); do
            rp=$(realpath --relative-to="$indir" "$p")
            outpath="$outdir/$rp"
            current_outdir=$(dirname "$outpath")

            if [[ ! -d "$current_outdir" ]]; then
                mkdir -p "$current_outdir"
            fi

            dotfiles_copy_prompt "$indir" "$outdir" "$rp"

        done
    fi
}

dotfile_copy_template_prompt() {
    indir=$1
    outdir=$2
    relative_path=$3
    template_path=$indir/$relative_path.tmpl
    render_path=$indir/$relative_path

    if [[ ! -f "$template_path" ]]; then
        dotfiles_showmessage missing template $template_path
        exit 1
    fi

    if [[ -f "$render_path" ]]; then
        dotfiles_showmessage rendering $template_path would overwrite $render_path
        exit 1
    fi


    template_vars='$ZSH_FULL_NAME:$TMUX_FULL_NAME:$TMUX_SESSION_NAME:$ALACRITTY_FONT_SIZE:$HOME'
    envsubst "$template_vars" < $template_path > $render_path
    dotfiles_copy_prompt "$indir" "$outdir" "$relative_path"
    rm "$render_path"
}

dotfiles_zsh() {

    if [[ "$ZDOTDIR" != "$HOME/.config/zsh" ]]; then
        dotfiles_showmessage 'You need to set ZDOTDIR=$HOME/.config/zsh either in ~/.zshrc or /etc/zsh/zshenv'
        ZDOTDIR=$HOME/.config/zsh
    fi

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
    dotfile_copy_template_prompt "$SOURCE_DIR" "$tmux_conf_dir" tmux.conf
}

dotfiles_starship() {
    dotfiles_showmessage Copying starship config to $XDG_CONFIG_HOME
    dotfiles_copy_prompt "$SOURCE_DIR" "$XDG_CONFIG_HOME" starship.toml
}

dotfiles_alacritty() {
    conf_dir="$HOME/.config/alacritty"

    if [[ ! -d "$conf_dir" ]]; then
        mkdir -p "$conf_dir"
    fi

    dotfile_copy_template_prompt "$SOURCE_DIR" "$conf_dir" alacritty.yml
}

dotfiles_vim() {
    conf_dir="$XDG_CONFIG_HOME/vim"
    if [[ -f "$HOME/.vimrc" ]]; then
        dotfiles_showmessage 'You must remove ~/.vimrc'
        dotfiles_showmessage If you want to keep it, move it to $conf_dir/vim/vimrc
        exit 1
    fi

    mkdir -p "$XDG_DATA_HOME"/vim/{undo,swap,backup}

    if [[ ! -f "$conf_dir/autoload/plug.vim" ]]; then
        curl -fLo "$conf_dir/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    dotfiles_copy_prompt "$SOURCE_DIR" "$conf_dir" vimrc
    dotfiles_showmessage Installing vim plugins...
    vim +PlugInstall +qall
}

dotfiles_i3() {
    dotfiles_copy_dir_prompt "$SOURCE_DIR/i3" "$XDG_CONFIG_HOME/i3"
    dotfiles_copy_dir_prompt "$SOURCE_DIR/i3status" "$XDG_CONFIG_HOME/i3status"
}

dotfiles_sway() {
    dotfiles_copy_dir_prompt "$SOURCE_DIR/sway" "$XDG_CONFIG_HOME/sway"
    dotfiles_copy_dir_prompt "$SOURCE_DIR/waybar" "$XDG_CONFIG_HOME/waybar"
}

assert_command_available alacritty
assert_command_available curl
assert_command_available diff
assert_command_available dirname
assert_command_available envsubst
assert_command_available find
assert_command_available git
assert_command_available realpath
assert_command_available tmux
assert_command_available vim
assert_command_available starship

check_optional_command exa
check_optional_command bat

assert_font_available 'Iosevka Term:style=Regular'


INSTALL_SCRIPT_PATH=$0:A
SOURCE_DIR=$(dirname $INSTALL_SCRIPT_PATH)
source "$SOURCE_DIR/zsh/.zshenv"

# Add variables for templates
if [[ -f "$SOURCE_DIR/config.zsh" ]]; then
    source "$SOURCE_DIR/config.zsh"
else
    source "$SOURCE_DIR/default-config.zsh"
fi

dotfiles_zsh
dotfiles_tmux
dotfiles_starship
dotfiles_alacritty
dotfiles_vim
dotfiles_i3
dotfiles_sway
dotfiles_showmessage Complete!
