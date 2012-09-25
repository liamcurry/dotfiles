let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o', '\~$', 'node_modules']
let NERDTreeHijackNetrw = 0
let NERDTreeBookmarksFile = expand("$HOME/.vim/.NERDTreeBookmarks")

" Always open with NERDTree
au vimenter * NERDTree

" Open even when no files are specified
au vimenter * if !argc() | NERDTree | endif

" ...and then switch to the right buffer
au vimenter * wincmd p

" Close NERDTree automatically if it is the last buffer
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
