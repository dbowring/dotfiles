
plugins=(
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
    /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
);

for plugin in $plugins; do
    source "$plugin"
done

# zsh-completions is also recommended (typically automatically added to fpath
# by package manager)
