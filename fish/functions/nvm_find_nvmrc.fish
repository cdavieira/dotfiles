# obtained from 'https://github.com/nvm-sh/nvm?tab=readme-ov-file#fish'
# but edited a bit
function nvm_find_nvmrc
	if test -n "$XDG_CONFIG_HOME"
		set nvm_script "$XDG_CONFIG_HOME/nvm/nvm.sh"
	else
		set nvm_script "$HOME/.config/nvm/nvm.sh"
	end

	if ! type -q 'bass'
		echo "FISH_CONFIG_DIR/functions/nvm_find_nvmrc.fish: bass not found. Try to install it from 'https://github.com/edc/bass'"
		return
	end

	if test -e $nvm_script
		bass source $nvm_script --no-use ';' nvm_find_nvmrc
	else
		echo "FISH_CONFIG_DIR/functions/nvm_find_nvmrc: $nvm_script not found. Try to install nvm from 'https://github.com/nvm-sh/nvm'"
	end
end
