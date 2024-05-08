if status is-interactive
	# Commands to run in interactive sessions can go here

	# Static variables
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

	# Dynamic variables
	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH "$HOME/.cargo/bin"
	end

	if test -d "$HOME/.local/bin"
		set -x PATH $PATH "$HOME/.local/bin"
	end

	set editors 'nvim' 'vim' 'less'
	for editor in $editors
		type -q $editor
		if test $status -eq 0
			break
		end
	end
	if test $editor = 'nvim'; or $editor = 'vim'
		set -x EDITOR "$editor"
		set -x MANPAGER "$editor +Man!"
	end

	if type -q qutebrowser
		set -x BROWSER 'qutebrowser'
	end

	# Aliases
	alias ls 'ls --group-directories-first --color=auto'
	alias lx 'ls --group-directories-first --sort=time --color=auto'

	# Functions
	function multicd
			echo (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --position command --regex '^\.\.+$' --function multicd

	function cdl
		cd $argv
		ls
	end

else if status is-login
	# Commands to run in login sessions can go here
end
