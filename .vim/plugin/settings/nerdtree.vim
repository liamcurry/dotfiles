let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o', '\~$', 'node_modules']
let NERDTreeHijackNetrw = 0
au vimenter * NERDTree            " Always open with NERDTree
au vimenter * wincmd p            " ...and then switch to the right buffer

" Close NERDTree automatically if it is the last buffer
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
