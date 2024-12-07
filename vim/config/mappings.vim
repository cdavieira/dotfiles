vim9script

import './colorschemes.vim'
import './path.vim'

export def Setup(): void
	nnoremap <Leader>b <Cmd>Buffers<CR>
	#nnoremap <Leader>c <Cmd>vim9 g:RotateColor(+1)<CR>
	nnoremap <Leader>c <ScriptCmd>colorschemes.Rotate(+1)<CR>
	nnoremap <Leader>v <ScriptCmd>colorschemes.Rotate(-1)<CR>
	nnoremap <Leader>e <Cmd>NERDTreeToggle<CR>
	nnoremap <Leader>f <Cmd>Files<CR>
	nnoremap <Leader>p <Cmd>edit ~/repos/dotfiles/vim<CR>
	nnoremap <Leader>r <Cmd>source $MYVIMRC<CR>
	nnoremap <Leader>s <Cmd>Rg<CR>
	tnoremap <C-D> <C-W><C-C>
	#inoremap <expr> <C-q> pumvisible() ? asyncomplete#cancel_popup() : "\<C-q>"
enddef
