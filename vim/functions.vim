vim9script

def g:RotateColor(increment: number): void
	const colors = [
		'slate',
		'retrobox',
		'wildcharm',
		'evening',
		'desert',
		'habamax',
		'sorbet',
		# 'dracula',
	]
	const size = len(colors)
	const idx = index(colors, g:colors_name)
	if idx == -1
		echo 'ColorRotate error:' g:colors_name 'not found in the colorlist'
		return
	endif

	var next_idx = (idx + increment) % size
	if next_idx < 0
		next_idx = size + next_idx
	endif

	const next_colorscheme = next_idx >= size ? colors[0] : colors[next_idx]
	const colorscheme_relpath = 'colors/' .. next_colorscheme .. '.vim'
	if empty(globpath(&rtp, colorscheme_relpath))
		echo 'ColorRotate error:' next_colorscheme 'not found in the runtimepath'
		return
	endif

	execute "colorscheme" next_colorscheme
	echo "ColorRotate: current colorscheme:" next_colorscheme
enddef
