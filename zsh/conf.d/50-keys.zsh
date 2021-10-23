# Use `showkey -a` to get key binds
# Use `bindkey` to list existing binds

# Alias `ALT+{Left,Right}` to match Mac
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word


# Configure plugin history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
