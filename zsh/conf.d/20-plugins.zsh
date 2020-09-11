source $ZGEN_DIR/zgen.zsh

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/archlinux
  zgen oh-my-zsh plugins/cargo
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/django
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/docker-compose
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/pip
  zgen oh-my-zsh plugins/rust
  zgen oh-my-zsh plugins/rustup
  zgen oh-my-zsh plugins/sudo

  # zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-completions src
  # zgen load zsh-users/zsh-history-substring-search
  # zgen load zsh-users/zsh-syntax-highlighting
  
  zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train

  zgen save
fi
