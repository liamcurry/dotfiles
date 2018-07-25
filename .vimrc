if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start adding plugins
call plug#begin('~/.vim/plugged')
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'reasonml-editor/vim-reason-plus'
Plug 'vim-syntastic/syntastic'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
call plug#end()


" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>
au BufWritePre * :call LanguageClient_textDocument_formatting()

" Colors
set background=dark
color molokai
match ErrorMsg '\%>90v.\+'


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
set listchars=tab:→\                  " a tab should display as '  ', trailing whitespace as '.'
set listchars=space:·
set listchars+=trail:•                " show trailing spaces as dots
set listchars+=extends:…              " Character to show when column continues beyond screen
set listchars+=precedes:…             " Character to show when column continues beyond screen
set listchars+=eol:¬                  " Character to show when column continues beyond screen

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')
let s:opam_configuration = {}
function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')
function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')
function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')
let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line


" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_auto_jump = 2
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='✗'
let g:syntastic_style_error_symbol='✗'
let g:syntastic_style_warning_symbol='✗'
let g:syntastic_python_checkers=['flake8', 'py3kwarn']
let g:syntastic_go_checkers=['gofmt', 'golint', 'govet']
let g:syntastic_javascript_checkers=[]

" NERDTree
let g:NERDTreeIgnore = [
    \ '\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o', '\~$', '.git',
\ ]
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeBookmarksFile = expand("$HOME/.vim/.NERDTreeBookmarks")
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusLine = 0
let g:NERDTreeMinimalUI = 1
au vimenter * NERDTree                            " Always open with NERDTree
au vimenter * if !argc() | NERDTree | endif       " Open even when no files are specified
au vimenter * wincmd p                            " ...and then switch to the right buffer
" Close NERDTree automatically if it is the last buffer
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>w :NERDTreeToggle<CR>

" Git Gutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '−'
let g:gitgutter_sign_removed_first_line = '−'
let g:gitgutter_sign_modified_removed = '−~'

" vim-airline
let g:airline#extensions#tabline#enabled = 1
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'
"let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
