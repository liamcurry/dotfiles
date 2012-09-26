nm <silent> gs :Gstatus<cr>
nm <silent> gb :Gbrowse<cr>
nm <silent> gd :call ToggleGdiff()<cr>
nm gc :gcommit
nm gm :gmove

let g:gdiff_is_loaded = 0

function ToggleGdiff()
  if (g:gdiff_is_loaded)
    let g:gdiff_is_loaded = 0
    only
    %foldopen!
    NERDTreeToggle
    execute "normal \<c-l>"
  else
    let g:gdiff_is_loaded = 1
    NERDTreeToggle
    Gdiff
  endif
endfunction
