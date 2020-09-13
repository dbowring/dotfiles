
" Setup XDG compliance
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'crusoexia/vim-monokai'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" ctrlp config, https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


set encoding=utf-8
set t_Co=256
syntax on
colorscheme monokai

" Show whitespace
set listchars=eol:$,tab:>-,trail:~,extends:›,precedes:‹,nbsp:·
set list

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

set number relativenumber
set nu rnu
