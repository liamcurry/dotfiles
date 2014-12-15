set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" general plugins
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-unimpaired'

" tagbar
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<Leader>s'

" NERDTree
Plugin 'scrooloose/nerdtree'
let NERDTreeIgnore = [
  \ '\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o', '\~$',
  \ ]
let NERDTreeHijackNetrw = 0
let NERDTreeBookmarksFile = expand("$HOME/.vim/.NERDTreeBookmarks")
let NERDTreeShowHidden = 1
let NERDTreeStatusLine = 0
let NERDTreeMinimalUI = 1
au vimenter * NERDTree                            " Always open with NERDTree
au vimenter * if !argc() | NERDTree | endif       " Open even when no files are specified
au vimenter * wincmd p                            " ...and then switch to the right buffer
" Close NERDTree automatically if it is the last buffer
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <leader>w :NERDTreeToggle<CR>

" vim-airline
Plugin 'bling/vim-airline'
let g:airline_powerline_fonts = 1

" CtrlP
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<C-t>'
let g:ctrlp_max_height = 10
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules\|\.sass-cache\|\.ve\|virtualenv\|venv',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.DS_Store$',
  \ 'link': '',
  \ }

" Syntastic
Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_auto_jump = 2
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='⚠'
let g:syntastic_python_checkers=['flake8', 'py3kwarn']
let g:syntastic_go_checkers=['gofmt', 'golint', 'govet']
"let g:syntastic_python_checker_args = \"--ignore=E128,E501"

" html
Plugin 'othree/html5.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'vim-scripts/django.vim'
au BufNewFile,BufRead *.html setlocal ft=htmldjango
au BufNewFile,BufRead *.ejs setlocal filetype=html

" javascript
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'briancollins/vim-jst'

" vim-jsdoc
Plugin 'heavenshell/vim-jsdoc'
let g:jsdoc_default_mapping = 0
map <silent> <C-d> :JsDoc<CR>

" css
Plugin 'groenewege/vim-less'
Plugin 'wavded/vim-stylus'

" git
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'int3/vim-extradite'

" gitgutter
Plugin 'airblade/vim-gitgutter'
let g:gitgutter_sign_column_always = 1

" go
Plugin 'fatih/vim-go'
Plugin 'dgryski/vim-godef'
let g:gofmt_command="goimports"
let g:go_fmt_command="goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" python
au BufNewFile,BufRead *.cgi setlocal ft=python

" plain text files
Plugin 'tpope/vim-markdown'

" tmux
Plugin 'acustodioo/vim-tmux'
if $TMUX == ''
    set clipboard=unnamed                   " Have to set this to use *p, *dd, etc.
endif

" zsh
au BufNewFile,BufRead *.zsh-theme setlocal ft=zsh

" vim-json
Plugin 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" themes
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax enable

set background=dark
color molokai
match ErrorMsg '\%>90v.\+'

"hi StatusLine ctermbg=bg ctermfg=white
"hi StatusLineNC ctermbg=bg
hi VertSplit ctermbg=bg ctermfg=bg
"hi LineNr ctermbg=bg
"hi GitGutterAdd ctermbg=bg
"hi GitGutterChange ctermbg=bg
"hi GitGutterDelete ctermbg=bg
"hi GitGutterChangeDelete ctermbg=bg
""hi CursorLine ctermbg=16
"hi SignColumn ctermbg=bg
"hi LineNr ctermbg=bg
"hi Operator ctermfg=3
"hi Pmenu ctermfg=white
"hi PmenuSel ctermfg=white
"


" Movement
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Use CTRL-S for saving, also in Insert mode
nnoremap <C-S> :<C-U>update<CR>
vnoremap <C-S> :<C-U>update<CR>gv
cnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

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

" Encoding
set encoding=utf-8                    " Default encoding is UTF-8
set fileencodings=ucs-bom,utf-8,latin1

" Whitespace
set shiftwidth=4                      " Default tab width is 2 spaces
set shiftround                        " Always round indents to multiples of shiftwidth
set tabstop=4                         " Default tab width is 2 spaces
set softtabstop=4                     " How many spaces a tab should be
"set expandtab                         " Use spaces for tabs
"set smarttab                          " Use spaces for tabs
set list                              " Show hidden characters
"set autoindent                        " Autoindent, obviously
set backspace=indent,eol,start        " Backspace through everything in insert mode

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

" Disable .swp files for watchdog
set nowritebackup
set noswapfile
set nobackup

" Backup and swap directories
set backupdir=~/.vim/.backup//        " Where to put backup files
set directory=~/.vim/.temp//          " Where to put swap files
if has('undofile')
  set undodir=~/.vim/.undo//            " Where to put undo files
  set undofile                          " Enable undo files
endif

" List chars
set listchars=""                      " Reset the listchars
set listchars=tab:▸\                  " a tab should display as '  ', trailing whitespace as '.'
set listchars+=trail:•                " show trailing spaces as dots
set listchars+=extends:…              " Character to show when column continues beyond screen
set listchars+=precedes:…             " Character to show when column continues beyond screen
set listchars+=eol:¬                  " Character to show when column continues beyond screen

" Highlighting
" older versions of vim don't have 'cc'
if has('cc')
  set cc=0                             " Shows cursor column at line 80
endif
set cursorline

" Remove trailing whitespace
au BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Automatically retab on save
au BufWrite * | silent! retab

" Some special stuff for crontab
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif
