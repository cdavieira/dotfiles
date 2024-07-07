if status is-interactive
	# Commands to run in interactive sessions can go here

	#######################################
	########## Static variables ###########
	#######################################

	# set LANG 'de_DE.UTF-8'
	set -x GMAIL 'cd.vieira14@gmail.com'
	set -x OUTLOOK 'cd_vieira@hotmail.com'
	set -x EMAIL $GMAIL
	set -x GPG_TTY "$(tty)"

	# xdg user directories
	# analogous to /etc
	set -x XDG_CONFIG_HOME "$HOME/.config"

	# analogous to /var/cache
	set -x XDG_CACHE_HOME "$HOME/.cache"

	# analogous to /usr/share
	set -x XDG_DATA_HOME "$HOME/.local/share"

	# analogous to /var/lib
	set -x XDG_STATE_HOME "$HOME/.local/state"

	# 'pam_systemd' sets XDG_RUNTIME_DIR automatically
	# set -x XDG_RUNTIME_DIR "/run/user/$UID"

	# both are analogous to PATH
	# set -x XDG_DATA_DIRS "/usr/local/share:/usr/share"
	# set -x XDG_CONFIG_DIRS "/etc/xdg"

	#######################################
	######### Dynamic variables ###########
	#######################################
	# add rust package manager's 'bin/' to path
	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH "$HOME/.cargo/bin"
	end

	# add '~/.local/bin/' to path
	if test -d "$HOME/.local/bin"
		set -x PATH $PATH "$HOME/.local/bin"
	end

	# set EDITOR env var
	set editors 'vim' 'nvim' 'less'
	for editor in $editors
		if type -q $editor
			set -x EDITOR "$editor"
			break
		end
	end

	# in case neovim is installed, use it as pager
	if type -q 'nvim'
		set -x MANPAGER 'nvim +Man!'
	end

	# in case qutebrowser is installed, use it as def browser
	if type -q 'qutebrowser'
		set -x BROWSER 'qutebrowser'
	end

	#######################################
	############## Aliases ################
	#######################################
	alias ls 'ls --group-directories-first --color=auto'
	alias la 'ls --group-directories-first --color=auto -la'
	
	# shortcut tmux to automatically open my most used folders
	# if type -q 'tmux'
	# 	alias tmux "tmux new-session -c ~/dotfiles -n dotfiles \; \
	# 		new-window -c ~/notes -n notes \; \
	# 		new-window -c ~/code -n code \; \
	# 		new-window -c ~/code/c/projects/gwl_keys -n gwl_keys \; "
	# end

	alias view 'vim -R'

	alias dmesg 'dmesg -H'

	alias info 'info --vi-keys'

	#######################################
	########### Abbreviations #############
	#######################################

	# save some typing
	if type -q 'ranger'
		abbr -a do ranger $HOME/dotfiles
		abbr -a no ranger $HOME/notes
		abbr -a co ranger $HOME/code
	else
		abbr -a do cd $HOME/dotfiles
		abbr -a no cd $HOME/notes
		abbr -a co cd $HOME/code
	end

	#######################################
	############# Functions ###############
	#######################################

	# use '......' idiom to move to any directory level up
	function multicd
			echo (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --position command --regex '^\.\.+$' --function multicd

	# copy the old cd command from fish and enhance it with ls
	functions -c cd oldcd
	function cd
		oldcd $argv
		ls
	end

else if status is-login
	# Commands to run in login sessions can go here
end
