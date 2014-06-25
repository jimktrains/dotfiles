set tabstop=2
set shiftwidth=2
set expandtab
syntax on
set nowrap
set hlsearch
set autoindent
set number
set showmatch
filetype plugin on

nnoremap <F2> :echomsg (!"phpm --short ".shellescape(expand("<cword>")))<CR>
nnoremap <F3> :execute ("!phpm ".shellescape(expand("<cword>")))<CR>

execute pathogen#infect()

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%110v.\+/
set colorcolumn=76,110
