vim9script

const rotatable_colors = [
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

const size = len(rotatable_colors)

def GetNextIndex(cur_idx: number, increment: number, arrsize: number): number
	var next_idx = (cur_idx + increment) % arrsize
	if next_idx < 0
		next_idx = arrsize + next_idx
	endif
	return next_idx
enddef

def Rotatable(name: string): bool
	var cur_idx: number = index(rotatable_colors, name)
	return cur_idx != -1
enddef

def IsAvailable(name: string): bool
	var relpath = 'colors/' .. name .. '.vim'
	var pathtocs = globpath(&rtp, relpath)
	var available = !empty(pathtocs)
	return available
enddef

def SetColor(name: string): bool
  if !IsAvailable(name)
	return false
  endif
  execute "colorscheme" name
  return true
enddef

export def SetCS(...names: list<string>): void
  # 'background' and 'colorscheme' operate together to set vim's visuals
  set background=dark
  for mycolor in names
    if SetColor(mycolor)
      break
    endif
  endfor
enddef

export def Rotate(increment: number): void
	var cur_colorscheme = g:colors_name
	if !Rotatable(cur_colorscheme)
		redraw | echo 'ColorRotate error:' cur_colorscheme 'not found in the rotatable colorlist'
		return
	endif

	var tries = 0
	var cur_idx: number = index(rotatable_colors, cur_colorscheme)
	var next_idx: number = GetNextIndex(cur_idx, increment, size)
	var next_colorscheme = rotatable_colors[next_idx]
	while tries < size && !IsAvailable(next_colorscheme)
		next_idx = GetNextIndex(next_idx, increment, size)
		next_colorscheme = rotatable_colors[next_idx]
		tries += 1
	endwhile

	execute "colorscheme" next_colorscheme

	# :help echo
	redraw | echo "ColorRotate: current colorscheme:" next_colorscheme
enddef
