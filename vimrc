set tabstop=3
set shiftwidth=3
syntax on
set nowrap
set hlsearch
set autoindent
set number
set showmatch
filetype plugin on
set list
set listchars=extends:⣿,precedes:⣿,tab:>-,trail:⠐

nnoremap <F2> :echomsg system("phpm --short ".shellescape(expand("<cword>")))<CR>
nnoremap <F3> :execute ("!phpm  ".shellescape(expand("<cword>")))<CR>
