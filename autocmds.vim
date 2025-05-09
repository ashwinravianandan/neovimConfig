augroup vimrc
   autocmd!
   au BufRead *.tsx set ft=typescript
   au BufRead *.jsx set ft=javascript
   au filetype haskell  call HaskellMode()
   au filetype markdown nmap <silent><buffer> <C-B> :call MarkDownToHtml()<CR>
   au filetype norg nmap <silent><buffer> <C-B> :lua require("personal.utils").export_as_md()<CR>
   " au filetype norg imap <silent><buffer> <C-l><C-o> :Telescope neorg insert_link<CR>
   au filetype markdown set spell
   au filetype cpp autocmd vimrc BufWritePost <buffer> call UpdateTags()
   au filetype javascript call JsMode()
   au filetype typescript call JsMode()
augroup END

"Using par
"vim build tags for project"
silent function! LoadTags( channel )
silent! execute "cs add GTAGS"
echo "GTAGS built and loaded"
endfunction

silent function! UpdateTags()
if filereadable("GTAGS")
   silent! execute "cs kill 0"
   call job_start( "global -u", { "close_cb": "LoadTags" } )
endif
endfunction

silent function! BuildTags(  )
if !filereadable( "GTAGS" )
   silent! execute "cs kill 0"
   call job_start( "gtags-cscope -b", { "close_cb": "LoadTags" })
else
   silent! execute "cs add GTAGS"
endif
enew
Explore
endfunction

function! JsMode()
   setlocal tabstop=2
   setlocal shiftwidth=2
endfunction

function HaskellMode()
   call g:deoplete#enable()
   inoremap <buffer> ( ()<Left>
endfunction

