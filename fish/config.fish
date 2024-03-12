if status is-interactive
	# Commands to run in interactive sessions can go here

	# set LANG 'de_DE.UTF-8'

	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH $HOME/.cargo/bin
	end

	if test -d "$HOME/.local/bin"
		set -x PATH $PATH $HOME/.local/bin
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

	function multicd
			echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --position command --regex '^\.\.+$' --function multicd

	alias ls 'ls --group-directories-first --color=auto'

else if status is-login
	# Commands to run in login sessions can go here
end
