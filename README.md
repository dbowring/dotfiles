# dotfiles

Installs configuration for the following programs:

- [zsh](http://zsh.sourceforge.net/)
- [tmux](https://github.com/tmux/tmux)
- [alacritty](https://github.com/alacritty/alacritty)
- [vim](https://www.vim.org/)

Installs aliases for the following applications:

- [exa](https://github.com/ogham/exa)
- [bat](https://github.com/sharkdp/bat)

You need to install these programs yourself, though, in whatever way is appropriate for
your system.

## Requirements

- coreutils
- zsh
- git
- curl
- vim

## Install

- Install the requirements, and the programs to be configured
- Create and edit `config.zsh` if desired (`cp default-config.zsh config.zsh`)
- Run the installation script

```zsh
zsh install.zsh
```

```zsh
systemctl --user enable sway-idle
systemctl --user enable waybar
systemctl --user enable kanshi
```
