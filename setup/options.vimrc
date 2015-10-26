
set encoding=utf-8

" Colorscheme
set t_Co=256
syntax on
colorscheme monokai

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Powerline
set laststatus=2

" Show whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" `\t` options
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab


