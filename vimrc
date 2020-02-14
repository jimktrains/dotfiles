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

" execute pathogen#infect()

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
" Plugin 'git://github.com/scrooloose/nerdtree'
 Plugin 'git://github.com/ctrlpvim/ctrlp.vim'
" " Plugin 'git://github.com/swekaj/php-foldexpr.vim'
" "Plugin 'git://github.com/Valloric/YouCompleteMe'
" " Plugin 'joonty/vim-phpqa.git'
" Plugin 'shawncplus/phpcomplete.vim'
" Plugin '2072/PHP-Indenting-for-VIm'
 Plugin 'jwalton512/vim-blade'
" Plugin 'gregsexton/MatchTag'
" Plugin 'vim-scripts/QuickFixCurrentNumber'
" Plugin 'inkarkat/vim-ingo-library'
 Plugin 'alvan/vim-php-manual'
" " Plugin 'joonty/vdebug'
 Plugin 'tpope/vim-speeddating'
 Plugin 'jceb/vim-orgmode'
" Plugin 'https://github.com/m-kat/aws-vim'
" Plugin 'utl.vim'
"
Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
 Plugin 'garbas/vim-snipmate'
 Plugin 'honza/vim-snippets'
 Plugin 'SirVer/ultisnips'
 Plugin 'dantleech/vim-phpnamespace'
 Plugin 'arnaud-lb/vim-php-namespace'
" Plugin 'craigemery/vim-autotag'
" Plugin 'mattn/calendar-vim'
" Plugin 'inkarkat/vim-SyntaxRange'
" Plugin 'https://github.com/Yggdroot/indentLine'
Plugin 'posva/vim-vue'
Plugin 'terryma/vim-multiple-cursors'
let g:indentLine_setColors = 0
"let g:indentLine_color_tty_light = 15 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_char = '┆'

Plugin 'https://github.com/vim-syntastic/syntastic'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php']
autocmd BufNewFile,BufRead /home/jim/MSQC/code/**/l5/**/*.php let g:syntastic_php_checkers = ['php', 'phpcs']

let g:syntastic_yaml_checkers = ['yamllint'] " -c /home/jim/.yamllint']
let g:syntastic_yaml_yamllint_args = '-c /home/jim/.yamllint'


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

"let g:phpqa_messdetector_autorun = 0
"let g:phpqa_codesniffer_autorun = 0
"autocmd BufNewFile,BufRead /home/jim/MSQC/code/**/l5/*.php let g:phpqa_codesniffer_autorun = 1

let g:phpcomplete_parse_docblock_comments = 1



autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade " Fix blade auto-indent

set wildmode=longest,list,full
set wildmenu

autocmd FileType c,cpp,java,php,h,hpp,py,rb,yml,yaml,org,xml,html,txt,md,textile autocmd BufWritePre * %s/\s\+$//e
"autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

autocmd FileType php inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
autocmd FileType php inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

let g:autotagDisabled='off'
autocmd FileType php let g:autotagDisabled=''


set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

let g:org_heading_shade_leading_stars=0
let g:org_agenda_files=['/home/jim/Dropbox/org/*.org', '/home/jim/MSQC/code/jims-org-repo/*.org']
let g:org_todo_keywords=['TODO', 'IN-PROGRESS', 'REVIEW', '|', 'DONE', 'DELEGATED']
let g:org_indent = 1

autocmd FileType vue syntax sync fromstart
let g:vue_pre_processors = ['scss']
