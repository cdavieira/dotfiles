vim9script

nnoremap <Leader>b <Cmd>Buffers<CR>
#nnoremap <Leader>c <Cmd>edit $MYVIMRC<CR>
nnoremap <Leader>c <Cmd>Files ~/repos/dotfiles/vim<CR>
nnoremap <Leader>e <Cmd>NERDTreeToggle<CR>
nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>r <Cmd>source $MYVIMRC<CR>
nnoremap <Leader>s <Cmd>Rg<CR>
nnoremap <Leader>q <Cmd>call g:RotateColor(-1)<CR>
nnoremap <Leader>w <Cmd>call g:RotateColor(+1)<CR>
noremap \ :term ++kill="kill"<CR>
tnoremap \ <CR><C-D>
inoremap <expr> <C-q> pumvisible() ? asyncomplete#cancel_popup() : "\<C-q>"
