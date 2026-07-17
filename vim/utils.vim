vim9script

def IsWindows(): bool
	return has('win64')
enddef

const sep = IsWindows() ? '\' : '/'

def BuildFilePath(dirs: list<string>): string
	return join(dirs, sep)
enddef

def BuildFilePath2(...dirs: list<string>): string
	return BuildFilePath(dirs)
enddef

def LogMsg(msg: string): void
	redraw | echo msg
enddef

def RunShellCommand(...words: list<string>): void
	var prefix = IsWindows() ? ':!powershell -Command' : ':!bash -c'
	var content = join(words, ' ')
	var cmd = prefix .. ' "' .. content .. '"'
	execute cmd
enddef

def GetDownloadCmd(_url: string, file_destination: string): string
	if IsWindows()
		return '!powershell -Command \"iwr -useb ' .. _url .. ' | ni ' .. file_destination .. ' -Force \"'
	endif
	return '!curl -fLo ' .. file_destination .. ' --create-dirs ' .. _url
enddef

export def WriteToStdout(...words: list<string>): void
	if IsWindows()
		var content = join(words, ' ')
		var cmd = 'echo ' .. content
		RunShellCommand(cmd)
	else
		writefile(words, '/dev/stdout', 'a')
	endif
enddef

def FileExists(path: string): bool
	return !empty(glob(path))
enddef

def FolderExists(path: string): bool
	return isdirectory(path)
enddef

def FindFirstAvailablePath(paths: list<list<string>>): string
	var folderpath: string

	# i'm pretty sure there's a builtin function which does this lol
	for _path in paths
		folderpath = BuildFilePath(_path)
		if FolderExists(folderpath)
			return folderpath
		endif
	endfor

	return ""
enddef

def FindMyVimConfigDir(): string
	const PATHS = IsWindows() ?
	[
	  [$HOME, 'vimfiles'],
	] :
	[
	  [$HOME, '.config', 'vim'],
	]

	return FindFirstAvailablePath(PATHS)
enddef

def FindMyVimCacheDir(): string
	const PATHS = IsWindows() ?
	[
	  # [getenv('MYVIM_CONFIG_DIR'), 'cache'],
	  [$HOME, 'vimfiles', 'cache'],
	] :
	[
	  [$HOME, '.cache', 'vim'],
	]

	return FindFirstAvailablePath(PATHS)
enddef

export def GetVimConfig(configname: string): string
	return BuildFilePath2(getenv('MYVIM_FILES'), configname .. '.vim')
enddef

export def GetPluginConfig(pluginname: string): string
	return BuildFilePath2(getenv('MYVIM_FILES'), 'plugins', pluginname .. '.vim')
enddef

# Setup MYVIM_* environment variables
# Overview of some environment variables i set in this vimrc:
# $MYVIM_CONFIG_DIR  - the path to the directory where vim expects to find your 'vimrc' file
# $MYVIM_CACHE_DIR   - the path to the directory where vim will store '~', '.un' and '.swp' files
# $MYVIM_FILES       - the path to the root directory where my custom '.vim' files can be found
# $MYVIM_VIMPLUG_DIR - the path to the directory where vimplug will download plugins
export def SetupCustomEnvironmentVariables(): void
	if has('win64')
		setenv('MYVIM_CONFIG_DIR', BuildFilePath2($HOME, 'vimfiles'))
		setenv('MYVIM_CACHE_DIR', BuildFilePath2(getenv('MYVIM_CONFIG_DIR'), 'cache'))
		setenv('MYVIM_FILES', BuildFilePath2($HOME, 'Downloads', 'dotfiles', 'vim'))
	else
		setenv('MYVIM_CONFIG_DIR', BuildFilePath2($HOME, '.config', 'vim'))
		setenv('MYVIM_CACHE_DIR', BuildFilePath2($HOME, '.cache', 'vim'))
		setenv('MYVIM_FILES', BuildFilePath2($HOME, 'repos', 'dotfiles', 'vim'))
	endif
	setenv('MYVIM_BACKUP_DIR', BuildFilePath2(getenv('MYVIM_CACHE_DIR'), 'backup'))
	setenv('MYVIM_SWAP_DIR', BuildFilePath2(getenv('MYVIM_CACHE_DIR'), 'swap'))
	setenv('MYVIM_UNDO_DIR', BuildFilePath2(getenv('MYVIM_CACHE_DIR'), 'undo'))
	setenv('MYVIM_VIMINFO', BuildFilePath2(getenv('MYVIM_CACHE_DIR'), 'viminfo'))
	setenv('MYVIM_VIMPLUG_DIR', BuildFilePath2(getenv('MYVIM_CONFIG_DIR'), 'vim-plug'))
	# override the system MANPAGER, since vim might have trouble using it (ex: if MANPAGER='nvim')
	setenv('MANPAGER', 'vim +MANPAGER --not-a-term -')
enddef

export def SetupOSDependentOptions(): void
	if has('win64')
		set keywordprg=:help
		set shell=pwsh
		set shellcmdflag=-Command
	else
		set keywordprg=:Man
		# set shell=/bin/bash
		set shell=/usr/bin/fish
		set shellcmdflag=-c
		set rtp-=$VIM/vimfiles
		set rtp-=$VIM/vimfiles/after
		set packpath-=$VIM/vimfiles
		set packpath-=$VIM/vimfiles/after
		runtime ftplugin/man.vim
	endif
enddef

export def DownloadVimplugIfNeeded()
	if executable('git')
		const vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		const vimplug_autoload_file = BuildFilePath2(getenv('MYVIM_CONFIG_DIR'), 'autoload', 'plug.vim')
		const vimplug_install_cmd = GetDownloadCmd(vimplug_url, vimplug_autoload_file)
		if empty(glob(vimplug_autoload_file))
			silent execute vimplug_install_cmd
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
