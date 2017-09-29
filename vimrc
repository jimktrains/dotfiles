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
highlight ColorColumn ctermbg=red ctermfg=white

if has("autocmd")
  augroup GPGASCII
    au!
    au BufReadPost *.asc :%!gpg -q -d
    au BufReadPost *.asc |redraw
    au BufWritePre *.asc :%!gpg -q -e -a -r jim@jimkeener.com
    au BufWritePost *.asc u
    au VimLeave *.asc :!clear
  augroup END
endif " has ("autocmd")


set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" find:
"  - textile
"  - markdown
"
" Plugin 'git://git.wincent.com/command-t.git'
Plugin 'git://github.com/godlygeek/tabular'
Plugin 'git://github.com/scrooloose/nerdtree'
Plugin 'git://github.com/ctrlpvim/ctrlp.vim'
" Plugin 'git://github.com/swekaj/php-foldexpr.vim'
" Plugin 'git://github.com/Valloric/YouCompleteMe'
Bundle 'joonty/vim-phpqa.git'
Plugin 'shawncplus/phpcomplete.vim'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'jwalton512/vim-blade'
Plugin 'gregsexton/MatchTag'
Plugin 'vim-scripts/QuickFixCurrentNumber'
Plugin 'inkarkat/vim-ingo-library'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
":PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"autocmd FileType c++ Bundle 'Valloric/YouCompleteMe'
"autocmd FileType c Bundle 'Valloric/YouCompleteMe'
"autocmd FileType python Bundle 'Valloric/YouCompleteMe'
"autocmd FileType shell Bundle 'Valloric/YouCompleteMe'
"autocmd FileType php Bundle 'Valloric/YouCompleteMe'

let g:enable_ycm_at_startup = 0
let g:loaded_youcompleteme = 1 

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_autorun = 1

autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade " Fix blade auto-indent

set wildmode=longest,list,full
set wildmenu

autocmd FileType c,cpp,java,php,h,hpp,py,rb autocmd BufWritePre <buffer> %s/\s\+$//e

function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

