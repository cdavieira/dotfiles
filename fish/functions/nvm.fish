# DESCRIPTION
#
# This fish script attempts to port nvm to fish using 'bass' and was obtained
# from 'https://github.com/nvm-sh/nvm?tab=readme-ov-file#fish' (but edited a
# bit)

# REQUIREMENTS
#
# bass has to be installed and the repository of nvm available
#
# In order to download and install bass:
#   'git clone https://github.com/edc/bass ~'
#   'make -C ~/bass install'
#   'make -C ~/bass test'
# Or follow the instructions found in 'https://github.com/edc/bass'
#
# In order to download nvm:
#   'git clone https://github.com/nvm-sh/nvm ~/.config/nvm'

# NOTES
#
# It's worth mentioning that there are other ways to use 'nvm' in fish.
# Check some of those alternatives:
#   https://github.com/jorgebucaran/nvm.fish
#   https://github.com/FabioAntunes/fish-nvm

function nvm
	if test -n "$XDG_CONFIG_HOME"
		set nvm_script "$XDG_CONFIG_HOME/nvm/nvm.sh"
	else
		set nvm_script "$HOME/.config/nvm/nvm.sh"
	end

	if ! type -q 'bass'; or ! test -e $nvm_script
		return
	end

	bass source $nvm_script --no-use ';' nvm $argv
end

function nvm_find_nvmrc
	if test -n "$XDG_CONFIG_HOME"
		set nvm_script "$XDG_CONFIG_HOME/nvm/nvm.sh"
	else
		set nvm_script "$HOME/.config/nvm/nvm.sh"
	end

	if ! type -q 'bass'; or ! test -e "$nvm_script"
		return
	end

	bass source $nvm_script --no-use ';' nvm_find_nvmrc
end

function nvm_load --on-variable="PWD"
	set -l default_node_version (nvm version default)

	set -l node_version (nvm version)

	set -l nvmrc_path (nvm_find_nvmrc)

	if test -n "$nvmrc_path"
		set -l nvmrc_node_version (nvm version (cat $nvmrc_path))

		if test "$nvmrc_node_version" = "N/A"
			nvm install (cat $nvmrc_path)
		else if test "$nvmrc_node_version" != "$node_version"
			nvm use $nvmrc_node_version
		end
	else if test "$node_version" != "$default_node_version"
		if test "$default_node_version" = "N/A"
			nvm install --lts --default
		else
			nvm use default
		end
	end
end
