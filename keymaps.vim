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

tnoremap <silent> <Leader>l <C-\><C-N><c-w>l 
tnoremap <silent> <Leader>j <C-\><C-N><c-w>j 
tnoremap <silent> <Leader>h <C-\><C-N><c-w>h 
tnoremap <silent> <Leader>k <C-\><C-N><c-w>k 
tnoremap <silent> <Leader>x <C-\><C-N><c-w>x 
tnoremap <silent> <Leader>c <C-\><C-N><c-w>c 
tnoremap <silent> <Leader>o <C-\><C-N><c-w>o 
tnoremap <silent> <Leader>v <C-\><C-N><c-w>v 
tnoremap <silent> <Leader>s <C-\><C-N><c-w>s 
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
