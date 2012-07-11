source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim

call pathogen#infect()
filetype plugin indent on
syntax on

color molokai

" Movement
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

imap jj <Esc>

nnoremap <leader><space> :noh<cr>     " Clear search highlighting
nnoremap <tab> %                      " Match bracket pairs with <tab>
vnoremap <tab> %                      " Match bracket pairs with <tab>

" General settings
set ruler                             " Show line/column numbers
set nocompatible                      " Use vim, no vi defaults
set number                            " Show line numbers
set hidden                            " Save buffers when a tab is closed
set showmatch                         " Show matching brackets
set noerrorbells visualbell t_vb=     " Turn off annoying bells
set cul                               " Highlight current line
set autochdir                         " Automatically cd into directory with file
set laststatus=2                      " Always show the status line
set t_Co=256                          " Make sure vim knows it's 256 colors
set tildeop                           " Easily switch caps for line

" Encoding
set encoding=utf-8                    " Default encoding is UTF-8
setglobal fileencoding=utf-8
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

" Folding
set foldenable                        " Turn on folding
set foldmethod=marker                 " Fold on marker
set foldlevel=100                     " Don't autofold anything
set foldopen=block,hor,mark,percent,quickfix,tag " Movement that opens folds
function SimpleFoldText()
  return getline(v:foldstart).' '
endfunction
set foldtext=SimpleFoldText()         " Custom font fold function (cleaner)

" Word wrap
set nowrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=85

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
set backupdir=~/.vim/_backup//        " Where to put backup files
set directory=~/.vim/_temp//          " Where to put swap files

" List chars
set listchars=""                      " Reset the listchars
set listchars=tab:▸\                  " a tab should display as '  ', trailing whitespace as '.'
set listchars+=trail:•                " show trailing spaces as dots
set listchars+=extends:…              " Character to show when column continues beyond screen
set listchars+=precedes:…             " Character to show when column continues beyond screen
set listchars+=eol:¬                  " Character to show when column continues beyond screen

" Highlighting
set cursorcolumn
set cursorline

" Make Python follow PEP-8
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
au FileType html,htmldjango,javascript set softtabstop=2 tabstop=2 shiftwidth=2

" Enable spell check for certain files
au FileType markdown set spell

" Treat JSON files like Javascript
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.html set ft=htmldjango

" Nginx
au BufNewFile,BufRead *.conf set ft=nginx

" CGI
au BufNewFile,BufRead *.cgi set ft=python

" Use real tabs in make files
au FileType make set noexpandtab

" Powerline
let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_enabled = 1

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_quiet_warnings = 0
let g:syntastic_enable_highlighting = 1

" CtrlP
let g:ctrlp_map = '<c-t>'
let g:ctrlp_max_height = 10
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules\|\.sass-cache',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.DS_Store$',
  \ 'link': '',
  \ }

" Nerdtree
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o', '\~$', 'node_modules']
let NERDTreeHijackNetrw = 0
au vimenter * NERDTree            " Always open with NERDTree
au vimenter * wincmd p            " ...and then switch to the right buffer

" Close NERDTree automatically if it is the last buffer
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>/
