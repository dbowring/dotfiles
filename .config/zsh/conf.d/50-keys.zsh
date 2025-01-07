# Use `showkey -a` to get key binds
# Use `bindkey` to list existing binds

# Alias `ALT+{Left,Right}` to match Mac
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word

# Home/end
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line
# Delete
bindkey "^[[3~" delete-char

# (ctrl|alt)+delete
bindkey '^[^?' backward-delete-word
bindkey '^H' backward-delete-word
bindkey '\e^?' backward-delete-word
bindkey '^[^?' backward-delete-word

# Configure plugin history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Support delete key
bindkey "^[[3~" delete-char
