if status is-interactive
	# Commands to run in interactive sessions can go here
	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH $HOME/.cargo/bin
	end

	if test -f "$HOME/.lynx/lynx.cfg"
		set -x LYNX_CFG "$HOME/.lynx/lynx.cfg"
		# not working in arch
		# set -x LYNX_LSS "bright-blue.lss"
	end

	if test -d "$HOME/.local/bin"
		set -x PATH $PATH $HOME/.local/bin
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

	alias ls 'ls --group-directories-first --color=auto'

	function multicd
			echo builtin cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
	end
	abbr --add dotdot --regex '^\.\.+$' --function multicd

	function cd
		builtin cd $argv
		ls
	end
end
