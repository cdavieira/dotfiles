vim9script

const DOTFILES_DIRPATH = resolve(expand($MYVIMRC))

const UTILS_FILEPATH   = fnamemodify(DOTFILES_DIRPATH, ':p:h') .. (has('win64') ? '\' : '/') .. 'utils.vim'

import UTILS_FILEPATH

import utils.GetVimConfig('colorschemes')

# Native
# OBS: <M-*> = Alt + *
tnoremap <C-D> <C-W><C-C>
nnoremap <Leader>c <ScriptCmd>colorschemes.Rotate(-1)<CR>
nnoremap <Leader>v <ScriptCmd>colorschemes.Rotate(+1)<CR>
nnoremap <Leader>p <Cmd>edit $MYVIM_FILES<CR>
nnoremap <Leader>r <Cmd>source $MYVIMRC<CR>
nnoremap <M-t> <Cmd>term ++noclose<CR>
tnoremap <M-t> <Cmd>quit!<CR>
tnoremap <M-q> <Cmd>quit!<CR>
vnoremap <Leader>y "+y

# Plugins
if g:MYVIM_USE_PLUGINS
	nnoremap <Leader>f <Cmd>Files<CR>
	nnoremap <Leader>b <Cmd>Buffers<CR>
	nnoremap <Leader>s <Cmd>Rg<CR>
	nnoremap <Leader>e <Cmd>NERDTreeToggle<CR>
	nnoremap <Leader>o <Cmd>Ollama toggle<CR>
	imap <expr> <C-j>       vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
	imap <expr> <C-l>       vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
	smap <expr> <C-l>       vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
	inoremap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
	snoremap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
	inoremap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
	snoremap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
	inoremap <expr> <C-y>   pumvisible() ? asyncomplete#close_popup()  : "\<C-y>"
	inoremap <expr> <C-e>   pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"
endif
