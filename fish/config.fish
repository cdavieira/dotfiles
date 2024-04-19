if status is-interactive
	# Commands to run in interactive sessions can go here

	# Static variables
	# set LANG 'de_DE.UTF-8'
	set -x GMAIL 'cd.vieira14@gmail.com'
	set -x OUTLOOK 'cd_vieira@hotmail.com'
	set -x EMAIL $GMAIL
	set -x GPG_TTY "$(tty)"

	# Dynamic variables
	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH "$HOME/.cargo/bin"
	end

	if test -d "$HOME/.local/bin"
		set -x PATH $PATH "$HOME/.local/bin"
	end

	if test -d "$HOME/mail"
		set -x MAIL "$HOME/mail"
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

	# Functions
	function multicd
			echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --position command --regex '^\.\.+$' --function multicd

	# Aliases
	alias ls 'ls --group-directories-first --color=auto'

else if status is-login
	# Commands to run in login sessions can go here
end
