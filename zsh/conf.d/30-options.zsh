# Force emacs mode
bindkey -e

# See: http://zsh.sourceforge.net/Doc/Release/Options.html

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list (even if it is not the 
# previous event). 
setopt HIST_IGNORE_ALL_DUPS

# This option both imports new commands from the history file, and also causes
# your typed commands to be appended to the history file
setopt HIST_REDUCE_BLANKS

# Remove command lines from the history list when the first character on the
#line is a space,
setopt HIST_IGNORE_SPACE

# Save each command’s beginning timestamp and the duration the history file
setopt EXTENDED_HISTORY

# Automatically list choices on an ambiguous completion. 
setopt AUTO_LIST

# Automatically use menu completion after the second consecutive request for
# completion
setopt AUTO_MENU

# If a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word.
setopt ALWAYS_TO_END
