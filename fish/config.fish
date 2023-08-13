if status is-interactive
    # Commands to run in interactive sessions can go here
	if test -d "$HOME/.cargo/bin"
		set -x PATH $PATH /home/carlosvieira/.cargo/bin
	end

	if test -f "$HOME/.lynx/lynx.cfg"
		set -x LYNX_CFG "/home/carlosvieira/.lynx/lynx.cfg"
	end
end
