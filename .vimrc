" Pathogen
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype plugin indent on
syntax on

" Theme
color molokai

" Movement
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

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
set laststatus=2                        " Always show the status line
set t_Co=256                            " Make sure vim knows it's 256 colors
set tildeop                             " Easily switch caps for line
set nospell                             " Turn off spell check
set modelines=5                         " Turn on modelines (they're off by default on OSX)
set clipboard=unnamed                   " Have to set this to use *p, *dd, etc.

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

" CGI
au BufNewFile,BufRead *.cgi setlocal ft=python

" Django
au BufNewFile,BufRead *.html setlocal ft=htmldjango

" Some special stuff for crontab
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
