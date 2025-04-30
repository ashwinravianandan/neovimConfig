"-------------------------------------------------------
" Mapping for , since it is used as the mapleader
"-------------------------------------------------------
nnoremap <c-e> ,
vnoremap <c-e> ,

"-------------------------------------------------------
" Key mappings - windows
"-------------------------------------------------------
nmap <silent> <Leader>l <c-w>l 
nmap <silent> <Leader>j <c-w>j 
nmap <silent> <Leader>h <c-w>h 
nmap <silent> <Leader>k <c-w>k 
nmap <silent> <Leader>x <c-w>x 
nmap <silent> <Leader>c <c-w>c 
nmap <silent> <Leader>o <c-w>o 
nmap <silent> <Leader>v <c-w>v 
nmap <silent> <Leader>s <c-w>s 
"Sets the current working directory as the directory in which the current file exists
nmap <silent> <Leader>wd :lcd! %:p:h<CR>

" inoremap < <><Left>
" inoremap <<space> <<space>
" inoremap << <<
" inoremap " ""<Left>
" inoremap ' ''<Left>
" inoremap ` ``<Left>
" inoremap ( ()<Left>
" inoremap [ []<Left>
" inoremap { {<CR>}O
" inoremap <C-u>" "
" inoremap <C-u>' '
" inoremap <C-u>< <
" inoremap <C-u>` `
" inoremap <C-u>( (
" inoremap <C-u>[ [
" inoremap <C-u>{ {
" inoremap <C-c>{ {}<Left>
" inoremap () ()
" inoremap {} {}
imap <Leader>o 
