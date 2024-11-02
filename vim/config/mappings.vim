vim9script

nnoremap <Leader>b <Cmd>Buffers<CR>
nnoremap <Leader>c <Cmd>call g:RotateColor(+1)<CR>
nnoremap <Leader>v <Cmd>call g:RotateColor(-1)<CR>
nnoremap <Leader>e <Cmd>NERDTreeToggle<CR>
nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>p <Cmd>NERDTreeToggle ~/repos/dotfiles/vim<CR>
nnoremap <Leader>r <Cmd>source $MYVIMRC<CR>
nnoremap <Leader>s <Cmd>Rg<CR>
nnoremap <Leader>w <Cmd>tabnew<CR>
nnoremap <Leader>q <Cmd>tabclose<CR>
nnoremap <Leader>j <Cmd>tabnext<CR>
nnoremap <Leader>k <Cmd>tabprev<CR>
tnoremap <C-D> <C-W><C-C>
inoremap <expr> <C-q> pumvisible() ? asyncomplete#cancel_popup() : "\<C-q>"
