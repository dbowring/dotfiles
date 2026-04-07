local _plugins=()

if [[ -x /opt/homebrew/bin/brew ]]; then
    # Mac w/homebrew
    local _prefix=$(brew --prefix)
    fpath+=( $_prefix/share/zsh-completions )
    _plugins+=(
        $_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        $_prefix/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        $_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    )
elif [[ -x /opt/pkg/bin/pkgin ]]; then
    # Mac w/pkgin
    local _prefix=/opt/pkg/
   _plugins+=(
        $_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        $_prefix/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        $_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    )
elif [[ -x /opt/local/bin/port ]]; then
    # Mac w/macports
    local _prefix=/opt/local
   _plugins+=(
        $_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        $_prefix/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        $_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    )
else
    # Linux
    _plugins+=(
        /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
        /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
        /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    );
    # zsh-completions is typically already on fpath for system package
    # installation, so don't need to updadte fpath
fi

for plugin in $_plugins; do
    source "$plugin"
done

if ( command -v fzf > /dev/null); then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi
