vim9script

# How to run this example
# :packadd packt
# (in normal mode) <Space>l
# (in normal mode) <Space>k
# (in normal mode) <Space>l

var FLAG = 1

export def MyTestFunction(): void
	FLAG = FLAG ? 0 : 1
enddef

export def MyLogTestFunction(): void
	echo FLAG
enddef

nnoremap <Leader>l <ScriptCmd>MyTestFunction()<CR>
nnoremap <Leader>k <ScriptCmd>MyLogTestFunction()<CR>
