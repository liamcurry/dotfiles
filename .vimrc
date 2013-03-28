" Pathogen
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype plugin indent on
syntax enable

" Theme
let g:solarized_contrast="high"
let g:solarized_visibility="high"
set background=dark
color solarized

hi SignColumn ctermbg=black
hi VertSplit ctermbg=black ctermfg=black
hi GitGutterAdd ctermbg=black
hi GitGutterChange ctermbg=black
hi GitGutterDelete ctermbg=black
hi GitGutterChangeDelete ctermbg=black
hi StatusLine ctermfg=white ctermbg=black
hi CursorLine ctermbg=bg
hi StatusLineNC ctermbg=white ctermfg=black
hi SyntasticErrorSign ctermbg=black
hi SyntasticWarningSign ctermbg=black
hi SyntasticStyleErrorSign ctermbg=black
hi SyntasticStyleWarningSign ctermbg=black
hi Error ctermbg=black
hi Todo ctermbg=black


" Movement
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Buffers
map <C-n> :bnext<cr>
map <C-p> :bprevious<cr>

" Panel management
nm <silent> <leader>- :split<cr>
nm <silent> <leader><leader> :vsplit<cr>
nm <silent> <leader>q :q<cr>

nm <leader><space> :noh<cr>     " Clear search highlighting
nm <tab> %                      " Match bracket pairs with <tab>
vm <tab> %                      " Match bracket pairs with <tab>

" General settings
set viminfo+=n$HOME/.vim/.temp/viminfo  " Custom location of the .viminfo file
set ruler                               " Show line/column numbers
set nocompatible                        " Use vim, no vi defaults
set number                              " Show line numbers
set hidden                              " Save buffers when a tab is closed
set showmatch                           " Show matching brackets
set noerrorbells visualbell t_vb=       " Turn off annoying bells
set cul                                 " Highlight current line
set autochdir                           " Automatically cd into directory with file
set laststatus=2                        " Never show the status line
set t_Co=256                            " Make sure vim knows it's 256 colors
set tildeop                             " Easily switch caps for line
set nospell                             " Turn off spell check
set modelines=5                         " Turn on modelines (they're off by default on OSX)
"set clipboard=unnamed                   " Have to set this to use *p, *dd, etc.

" Encoding
set encoding=utf-8                    " Default encoding is UTF-8
set fileencodings=ucs-bom,utf-8,latin1

" Whitespace
set shiftwidth=2                      " Default tab width is 2 spaces
set shiftround                        " Always round indents to multiples of shiftwidth
set tabstop=2                         " Default tab width is 2 spaces
set softtabstop=2                     " How many spaces a tab should be
set expandtab                         " Use spaces for tabs
set smarttab                          " Use spaces for tabs
set list                              " Show hidden characters
set autoindent                        " Autoindent, obviously
set backspace=indent,eol,start        " Backspace through everything in insert mode
au BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif " Remove trailing whitespace
au BufWrite * | silent! retab " Automatically retab on save

" Word wrap
set nowrap
set textwidth=79
set formatoptions=qrn1

" Searching
set hlsearch showmatch                " Highlight matches
set incsearch                         " Incremental searches
set ignorecase                        " Searching isn't case sensitive
set smartcase                         " ...unless they contain at least once capital letter
set gdefault                          " Add 'g' modifier to search automatically

" Wildmenu
set wildmenu
set wildignore=*.dll,*.o,*.pyc,*.jpg,*.png,*.gif
set wildmode=list:longest

" Backup and swap directories
set backupdir=~/.vim/.backup//        " Where to put backup files
set directory=~/.vim/.temp//          " Where to put swap files
set undodir=~/.vim/.undo//            " Where to put undo files
set undofile                          " Enable undo files

" List chars
set listchars=""                      " Reset the listchars
set listchars=tab:▸\                  " a tab should display as '  ', trailing whitespace as '.'
set listchars+=trail:•                " show trailing spaces as dots
set listchars+=extends:…              " Character to show when column continues beyond screen
set listchars+=precedes:…             " Character to show when column continues beyond screen
set listchars+=eol:¬                  " Character to show when column continues beyond screen

" Highlighting
set cc=80                             " Shows cursor column at line 80
set cursorline

au BufNewFile,BufRead *.cgi setlocal ft=python
au BufNewFile,BufRead *.html setlocal ft=htmldjango
au BufNewFile,BufRead *.zsh-theme setlocal ft=zsh

"au BufWritePost *.md,*.markdown :silent !cat %:p | curl -X PUT -T - http://localhost:8090/

" Some special stuff for crontab
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

let g:pymode_indent = 0             " Disable pymode indent -- use pep-8 indent instead

" CtrlP
let g:ctrlp_map = '<C-t>'
let g:ctrlp_max_height = 10
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules\|\.sass-cache\|\.ve',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.DS_Store$',
  \ 'link': '',
  \ }


" NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o', '\~$', 'node_modules']
let NERDTreeHijackNetrw = 0
let NERDTreeBookmarksFile = expand("$HOME/.vim/.NERDTreeBookmarks")
let NERDTreeShowHidden = 1

au vimenter * NERDTree                            " Always open with NERDTree
au vimenter * if !argc() | NERDTree | endif       " Open even when no files are specified
au vimenter * wincmd p                            " ...and then switch to the right buffer

" Close NERDTree automatically if it is the last buffer
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Powerline
" http://lokaltog.github.com/powerline/overview.html#vim-usage
"set rtp+=$HOME/.powerline/powerline/bindings/vim
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_cache_enabled = 1

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_quiet_warnings = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
"let g:syntastic_python_checker_args = \"--ignore=E128,E501"


" gitgutter
let g:gitgutter_sign_column_always = 1
