if status is-interactive
    # Commands to run in interactive sessions can go here
	if test -d "/home/carlosvieira/.cargo/bin"
		set -x PATH $PATH /home/carlosvieira/.cargo/bin
	end
end
