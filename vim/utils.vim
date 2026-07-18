vim9script

var VIM_PATHS: dict<any>

if has('win64')
	VIM_PATHS = {
		config: [
			[$HOME, 'vimfiles'],
		],
		cache: [
			[$HOME, 'vimfiles', 'cache'],
		],
		dotfiles: [
			[$HOME, 'Downloads', 'dotfiles', 'vim'],
		],
	}

	def BuildFilePath(dirs: list<string>): string
		return join(dirs, '\')
	enddef

	export def WriteToStdout(...words: list<string>): void
		var content = join(words, ' ')
		var cmd = 'echo ' .. content
		RunShellCommand(cmd)
	enddef

	def GetDownloadCmd(_url: string, file_destination: string): string
		return '!powershell -Command \"iwr -useb ' .. _url .. ' | ni ' .. file_destination .. ' -Force \"'
	enddef

	def RunShellCommand(...words: list<string>): void
		var content = join(words, ' ')
		var cmd = ':!powershell -Command "' .. content .. '"'
		execute cmd
	enddef

	export def SetupOSDependentOptions(): void
		set keywordprg=:help
		set shell=pwsh
		set shellcmdflag=-Command
	enddef
else
	VIM_PATHS = {
		config: [
			[$HOME, '.config', 'vim'],
		],
		cache: [
			[$HOME, '.cache', 'vim'],
		],
		dotfiles: [
			[$HOME, 'repos', 'dotfiles', 'vim'],
		],
	}

	def BuildFilePath(dirs: list<string>): string
		return join(dirs, '/')
	enddef

	export def WriteToStdout(...words: list<string>): void
		writefile(words, '/dev/stdout', 'a')
	enddef

	def GetDownloadCmd(_url: string, file_destination: string): string
		return '!curl -fLo ' .. file_destination .. ' --create-dirs ' .. _url
	enddef

	def RunShellCommand(...words: list<string>): void
		var content = join(words, ' ')
		var cmd = ':!bash -c "' .. content .. '"'
		execute cmd
	enddef

	export def SetupOSDependentOptions(): void
		set keywordprg=:Man
		set shell=/usr/bin/fish
		set shellcmdflag=-c
		set rtp-=$VIM/vimfiles
		set rtp-=$VIM/vimfiles/after
		set packpath-=$VIM/vimfiles
		set packpath-=$VIM/vimfiles/after
		runtime ftplugin/man.vim
	enddef
endif

def LogMsg(msg: string): void
	redraw | echo msg
enddef

def FindMyVimDir(dirname: string): string
	var count = len(VIM_PATHS[dirname])

	if count == 0
		return ""
	endif

	var folderpath_default: string = BuildFilePath(VIM_PATHS[dirname][0])

	if count == 1
		return folderpath_default
	endif

	# i'm pretty sure there's a builtin function which does this lol
	var folderpath: string
	for _path in VIM_PATHS[dirname]
		folderpath = BuildFilePath(_path)
		if isdirectory(folderpath)
			return folderpath
		endif
	endfor

	return folderpath_default
enddef

export def GetVimConfig(configname: string): string
	return BuildFilePath([getenv('MYVIM_FILES'), configname .. '.vim'])
enddef

export def GetPluginConfig(pluginname: string): string
	return BuildFilePath([getenv('MYVIM_FILES'), 'plugins', pluginname .. '.vim'])
enddef

export def SetupCustomEnvironmentVariables(): void
	# the path to the directory where vim expects to find your 'vimrc' file
	setenv('MYVIM_CONFIG_DIR', FindMyVimDir('config'))

	# the path to the directory where vim will store '~', '.un' and '.swp' files
	setenv('MYVIM_CACHE_DIR', FindMyVimDir('cache'))

	# the path to the root directory where my custom '.vim' files can be found
	setenv('MYVIM_FILES', FindMyVimDir('dotfiles'))

	# the path to the directory where vimplug will download plugins
	setenv('MYVIM_VIMPLUG_DIR', BuildFilePath([getenv('MYVIM_CONFIG_DIR'), 'vim-plug']))

	setenv('MYVIM_BACKUP_DIR', BuildFilePath([getenv('MYVIM_CACHE_DIR'), 'backup']))
	setenv('MYVIM_SWAP_DIR', BuildFilePath([getenv('MYVIM_CACHE_DIR'), 'swap']))
	setenv('MYVIM_UNDO_DIR', BuildFilePath([getenv('MYVIM_CACHE_DIR'), 'undo']))
	setenv('MYVIM_VIMINFO', BuildFilePath([getenv('MYVIM_CACHE_DIR'), 'viminfo']))

	# override the system MANPAGER, since vim might have trouble using it (ex: if MANPAGER='nvim')
	setenv('MANPAGER', 'vim +MANPAGER --not-a-term -')
enddef

export def DownloadVimplugIfNeeded()
	if executable('git')
		const vimplug_autoload_file = BuildFilePath([getenv('MYVIM_CONFIG_DIR'), 'autoload', 'plug.vim'])
		if empty(glob(vimplug_autoload_file))
			const vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
			silent execute GetDownloadCmd(vimplug_url, vimplug_autoload_file)
			autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		endif
	endif
enddef

export def CreateDirectoriesIfNeeded()
	for folder in [$MYVIM_BACKUP_DIR, $MYVIM_SWAP_DIR, $MYVIM_UNDO_DIR]
		if empty(glob(folder))
			mkdir(folder, 'p')
		endif
	endfor
enddef

# Wayland clipboard
# :help wayland-primary-selection

def Available(): bool
	return executable('wl-copy') && executable('wl-paste')
enddef

def Copy(reg: string, type: string, str: list<string>)
	var args = "wl-copy"

	if reg == "*"
	    args ..= " -p"
	endif

	system(args, str)
enddef

def Paste(reg: string): tuple<string, list<string>>
	var args = "wl-paste --type text/plain;charset=utf-8"

	if reg == "*"
	    args ..= " -p"
	endif

	return ("", systemlist(args))
enddef

v:clipproviders["wl_clipboard"] = {
	available: Available,
	copy: {
	    "+": Copy,
	    "*": Copy
	},
	paste: {
	    "+": Paste,
	    "*": Paste
	}
}
set clipmethod=wl_clipboard
