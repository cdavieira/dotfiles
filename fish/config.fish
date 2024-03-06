if status is-interactive
	# Commands to run in interactive sessions can go here
	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH $HOME/.cargo/bin
	end

	if test -d "$HOME/.local/bin"
		set -x PATH $PATH $HOME/.local/bin
	end

	if test -f "$HOME/.lynx/lynx.cfg"
		set -x LYNX_CFG "$HOME/.lynx/lynx.cfg"
		# not working in arch
		# set -x LYNX_LSS "bright-blue.lss"
	end

	if test -d "$HOME/.bun"
		set --export BUN_INSTALL "$HOME/.bun"
		set --export PATH $PATH $BUN_INSTALL/bin
	end

	if type -q 'nvim'
		set -x EDITOR 'nvim'
		set -x MANPAGER 'nvim +Man!'
	else if type -q 'vim'
		set -x EDITOR 'vim'
		set -x MANPAGER 'vim +Man!'
	end

	function multicd
			echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --position command --regex '^\.\.+$' --function multicd

	alias ls 'ls --group-directories-first --color=auto'

	set LANG 'de_DE.UTF-8'
else if status is-login
	# Commands to run in login sessions can go here
end
