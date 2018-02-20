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

" General settings
" set viminfo+=n$HOME/.vim/.temp/viminfo  " Custom location of the .viminfo file
set ruler                               " Show line/column numbers
set nocompatible                        " Use vim, no vi defaults
set number                              " Show line numbers
set hidden                              " Save buffers when a tab is closed
set showmatch                           " Show matching brackets
set noerrorbells visualbell t_vb=       " Turn off annoying bells
set cul                                 " Highlight current line
" set autochdir                           " Automatically cd into directory with file
set laststatus=2                        " Never show the status line
set t_Co=256                            " Make sure vim knows it's 256 colors
set tildeop                             " Easily switch caps for line
set nospell                             " Turn off spell check
set modelines=5                         " Turn on modelines (they're off by default on OSX)

" Encoding
set encoding=utf-8

" Whitespace
set shiftwidth=4
set shiftround
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set list
set backspace=indent,eol,start

" Word wrap
set nowrap
set textwidth=99
set formatoptions=qrn1

" Searching
set hlsearch showmatch
set incsearch
set ignorecase
set smartcase
set gdefault

" Remove trailing whitespace
au BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" List chars
set listchars=""                      " Reset the listchars
set listchars=tab:▸\                  " a tab should display as '  ', trailing whitespace as '.'
set listchars+=trail:•                " show trailing spaces as dots
set listchars+=extends:…              " Character to show when column continues beyond screen
set listchars+=precedes:…             " Character to show when column continues beyond screen
set listchars+=eol:¬                  " Character to show when column continues beyond screen
