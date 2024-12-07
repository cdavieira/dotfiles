vim9script

export def SetDefault(): void
	# 'background' and 'colorscheme' operate together to set vim's visuals
	set background=dark

	# Plugins
	colorscheme dracula
	# if has('lua') | colorscheme catppuccin | endif
	# colorscheme onedark
	# autocmd vimenter * ++nested colorscheme gruvbox

	# Builtin
	# colorscheme wildcharm
	# colorscheme slate
	# colorscheme retrobox
	# colorscheme evening
	# colorscheme desert
	# colorscheme habamax
	# colorscheme sorbet
enddef

#export def g:Rotate(increment: number): void
export def Rotate(increment: number): void
	const colors = [
		'catppuccin-mocha',
		'slate',
		'retrobox',
		'wildcharm',
		'evening',
		'desert',
		'habamax',
		'sorbet',
		'dracula',
		'onedark',
	]
	const size = len(colors)
	var tries = 0
	var cur_idx: number
	var next_idx: number
	var next_colorscheme = g:colors_name
	var next_colorscheme_relpath = ' '

	while tries < size && empty(globpath(&rtp, next_colorscheme_relpath))
		cur_idx = index(colors, next_colorscheme)
		if cur_idx == -1
			redraw | echo 'ColorRotate error:' g:colors_name 'not found in the colorlist'
			return
		endif

		next_idx = (cur_idx + increment) % size
		if next_idx < 0
			next_idx = size + next_idx
		endif

		next_colorscheme = next_idx >= size ? colors[0] : colors[next_idx]
		next_colorscheme_relpath = 'colors/' .. next_colorscheme .. '.vim'
		tries += 1
	endwhile

	execute "colorscheme" next_colorscheme

	# :help echo
	redraw | echo "ColorRotate: current colorscheme:" next_colorscheme
enddef
