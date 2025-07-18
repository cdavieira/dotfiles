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
	set add_to_path \
		"$HOME/.local/bin" \
		"$HOME/.cargo/bin" \
		"$HOME/.yarn/bin" \
		"/opt/riscv/bin" \
		"/opt/riscv32/bin" \
		"/usr/local/texlive/$(date +%Y)/bin/x86_64-linux"

	for dirpath in $add_to_path
		if test -d $dirpath; and not contains $dirpath $PATH
			set -x PATH $PATH $dirpath
		end
	end

	# set EDITOR env var
	set editors 'nvim' 'vim' 'less'
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
	# if type -q 'qutebrowser'
	# 	# https://github.com/qutebrowser/qutebrowser/blob/main/misc/org.qutebrowser.qutebrowser.desktop
	# 	# /usr/local/applications/org.qutebrowser.qutebrowser.desktop
	# 	xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
	# 	set -x BROWSER 'org.qutebrowser.qutebrowser.desktop'
	# end

	#######################################
	############## Aliases ################
	#######################################
	alias ls 'ls --group-directories-first --color=auto'
	alias la 'ls --group-directories-first --color=auto -la'
	
	# shortcut tmux to automatically open my most used folders
	# if type -q 'tmux'
	# 	alias tmux "tmux new-session -c ~/repos/dotfiles -n dotfiles \; \
	# 		new-window -c ~/repos/notes -n notes \; \
	# 		new-window -c ~/repos/code -n code \; "
	# end

	alias view 'vim -R'
	alias dmesg 'dmesg -H'
	alias info 'info --vi-keys'
	alias nv 'nvim'

	# in case lynx is installed, override its default cfg file with ours
	if type -q 'lynx'; and test -e ~/repos/dotfiles/lynx/lynx.cfg
		alias lynx 'lynx -cfg=~/repos/dotfiles/lynx/lynx.cfg'
	end


	#######################################
	########### Abbreviations #############
	#######################################

	abbr dc cd
	abbr sl ls
	abbr maek make

	#######################################
	############# Functions ###############
	#######################################

	# test vimscript files in the terminal
	if ! test (string match viml (functions))
		function viml
			for vimfile in (string match '*.vim' $argv)
				vim -es -c "source $vimfile" -c 'q'
			end
		end
	end

	# use '......' idiom to move to any directory level up
	function multicd
		echo (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --position command --regex '^\.\.+$' --function multicd

	# copy the old cd command from fish and enhance it with ls
	if ! test (string match oldcd (functions))
		functions -c cd oldcd
		function cd
			oldcd $argv
			ls
		end
	end

else if status is-login
	# Commands to run in login sessions can go here
end
