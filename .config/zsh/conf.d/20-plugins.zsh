local _plugins=()

if command -v brew > /dev/null; then
    # Mac w/homebrew
    local _prefix=$(brew --prefix)
    fpath+=( $_prefix/share/zsh-completions )
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
