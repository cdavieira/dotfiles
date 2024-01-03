#!/usr/bin/fish

# this script downloads a file of ~1.6GiB to the current working directory
# the file downloaded is the one described here: https://developer.riotgames.com/docs/lol#data-dragon
# references to everything used in this script can be found at the end of the file

set ddragon_version '13.24.1'
set ddragon_url "https://ddragon.leagueoflegends.com/cdn/dragontail-$ddragon_version.tgz"
set ddragon_file "dragontail-$ddragon_version.tgz"
set ddragon_dir "dragontail-$ddragon_version"
set ddragon_path "$(pwd)/$ddragon_dir"

function warn -d "prints a message in red"
	set_color red
	echo $argv
	set_color normal
end

function clarify -d "prints a message in green"
	set_color green
	echo $argv
	set_color normal
end

### action starts here

if not type -q wget
	warn "wget not found"
	exit
end

if not type -q gzip
	warn "gzip not found"
	exit
end

if not test -d $ddragon_dir
	clarify "'$ddragon_dir' not found. Creating it..."
	mkdir -p $ddragon_dir
end

cd $ddragon_dir

if not test -e $ddragon_file && not test -e (string replace tgz tar $ddragon_file)
	clarify "'$ddragon_file' not found in $ddragon_path. Fetching it..."
	wget $ddragon_url
end

if test -e $ddragon_file
	clarify "Extracting '$ddragon_file'..."
	gzip -d $ddragon_file
	tar -xf (string replace tgz tar $ddragon_file)
end


# fish references
# creating variables:
# https://fishshell.com/docs/current/tutorial.html#variables

# if clauses:
# https://fishshell.com/docs/current/tutorial.html#conditionals-if-else-switch
# https://fishshell.com/docs/current/commands.html
# https://fishshell.com/docs/current/cmds/test.html
# https://fishshell.com/docs/current/cmds/type.html

# colorized terminal output:
# https://fishshell.com/docs/current/cmds/set_color.html

# functions:
# https://fishshell.com/docs/current/cmds/function.html

# command substitution
# https://fishshell.com/docs/current/tutorial.html#command-substitutions

# string manipulation
# https://fishshell.com/docs/current/cmds/string.html
# https://fishshell.com/docs/current/cmds/string.html#replace-literal-examples
