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

	set -x EDITOR "nvim"

end
