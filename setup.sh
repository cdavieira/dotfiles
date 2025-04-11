#!/usr/bin/env bash

prefix=$HOME
reposdir=$prefix/repos
xdgconfigdir=$prefix/.config

clean_jq_output(){
	sed 's/null//g' | sort | uniq | tr -d '"' | tr '\n' ' '
}

# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
command_exists(){
	command -v $1 &>/dev/null
	return 
}

create_folders(){
	# creating home folders
	cd $prefix
	mkdir tmp save repos books german vids

	# creating $prefix/.config folders
	mkdir .config/{,vim,fish,kitty,tmux,waybar,qutebrowser,dunst}

	# creating $prefix/.cache folders
	mkdir -p .cache/vim/{,backup,swap,undo}
}

clone_repos(){
	cd ${reposdir}

	git clone https://github.com/cdavieira/dotfiles.git

	case $1 in
		'archlinux')
			GIT_REPOS=$(cat dotfiles/packages.yaml | yq '.altpackages.arch as $repos | .repos.git[] | { (.name): .url } | .[$repos[]]')
			;;
		'gentoo')
			GIT_REPOS=$(cat dotfiles/packages.yaml | yq '.altpackages.gentoo as $repos | .repos.git[] | { (.name): .url } | .[$repos[]]')
			;;
		*) 
			return ;;
	esac
	GIT_REPOS=$(echo $GIT_REPOS | clean_jq_output)

	# TODO: do the same thing for when downloading stuff through curl/wget
	for repo in $GIT_REPOS; do
	  git clone $repo
	done
}

make_links(){
	ln -sf ${reposdir}/dotfiles/fish/config.fish ${xdgconfigdir}/fish
	ln -sf ${reposdir}/dotfiles/vim/vimrc ${xdgconfigdir}/vim
	ln -sf ${reposdir}/dotfiles/vim/snippets ${xdgconfigdir}/vim
	ln -sf ${reposdir}/dotfiles/nvim/ ${xdgconfigdir}
	ln -sf ${reposdir}/dotfiles/tmux/tmux.conf ${xdgconfigdir}/tmux
	ln -sf ${reposdir}/dotfiles/mailcap/mailcap ~/.mailcap
	ln -sf ${reposdir}/dotfiles/dwl/waybar-config.jsonc ${xdgconfigdir}/waybar
	ln -sf ${reposdir}/dotfiles/dwl/waybar-style.css ${xdgconfigdir}/waybar
	ln -sf ${reposdir}/dotfiles/dunst/dunstrc ${xdgconfigdir}/dunst
	ln -sf ${reposdir}/dotfiles/qutebrowser/config.py ${xdgconfigdir}/qutebrowser
	case $1 in
		'archlinux')
			ln -sf ${reposdir}/dotfiles/kitty/kitty-arch.conf ${xdgconfigdir}/kitty
			;;
		'gentoo')
			ln -sf ${reposdir}/dotfiles/kitty/kitty-gentoo.conf ${xdgconfigdir}/kitty
			ln -sf ${reposdir}/dotfiles/gentoo/init.sh ~
			;;
		*) ;;
	esac
}

# TODO
build_dwl(){
	cd ${reposdir}/brillo
	# apply my patch
	make
	sudo make install
}

build_brillo(){
	sudo usermod -aG video carlos
	cd ${reposdir}/brillo
	make
	sudo make install
}

install_packages_gentoo(){
  cd ${reposdir}/dotfiles

  sudo cp gentoo/package.use/* /etc/portage/package.use/
  sudo cp gentoo/package.accept_keywords/* /etc/portage/package.accept_keywords/
  sudo cp gentoo/package.license/* /etc/portage/package.license/
  # TODO: incluir os pacotes ignorados no comando
  # cat packages.yaml | yq '. as $file | $file.all.gentoo.install.packages.system as $pkgs | $file.packages.system[] | select(.name as $n | $pkgs | index($n)) | [.gentoo] | flatten(1)[]'

  PKGS_ALL=$(cat packages.yaml | yq '. as $file | [.packages.system[].gentoo] + [.packages.user[].gentoo] | flatten(1) - $file.packages.ignore.gentoo | .[]')
  PKGS_ALL=$(echo $PKGS_ALL | clean_jq_output)

  SERVICES_DEFAULT=$(cat packages.yaml | yq '. as $file | .services.gentoo.default[] | flatten(1)[]')
  SERVICES_DEFAULT=$(echo $SERVICES_DEFAULT | clean_jq_output)

  sudo emerge -av $PKGS_ALL

  for serv in $SERVICES_DEFAULT; do
    sudo rc-update add $serv default
  done
}

install_packages_arch(){
  cd ${reposdir}/dotfiles

  PKGS_ALL=$(cat packages.yaml | yq '. as $file | [.packages.system[].arch] + [.packages.user[].arch] | flatten(1) - $file.packages.ignore.arch | .[]')
  PKGS_ALL=$(echo $PKGS_ALL | clean_jq_output)

  SERVICES_SYSTEM=$(cat packages.yaml | yq '. as $file | .services.arch.system[] | flatten(1)[]')
  SERVICES_SYSTEM=$(echo $SERVICES_SYSTEM | clean_jq_output)

  SERVICES_USER=$(cat packages.yaml | yq '. as $file | .services.arch.user[] | flatten(1)[]')
  SERVICES_USER=$(echo $SERVICES_USER | clean_jq_output)

  sudo pacman -S $PKGS_ALL
  sudo systemctl enable $SERVICES_SYSTEM
  sudo systemctl --user enable $SERVICES_USER
}

install_packages(){
	if ! command_exists yq ; then
		case $1 in
			'archlinux')
				sudo pacman -S jq
				;;
			'gentoo')
				sudo pacman -S app-misc/jq app-misc/yq
				;;
			*)
				return
				;;
		esac
	fi

	case $1 in
		'archlinux')
			install_packages_arch
			;;
		'gentoo')
			install_packages_gentoo
			;;
		*)
			;;
	esac
	build_dwl
	build_brillo
}

#################################
#################################
#################################

echo "Welcome to my setup script!"
echo "This setup script is meant to be used right after the installation of either: ArchLinux, Gentoo or another OS of my likings"
echo "Inform which distribution you are on right now:"

select linuxdistro in archlinux gentoo; do
	break
done

echo "Distribution selected: ${linuxdistro}. Is that right? [y/N]"
read confirmation
if ! test "${confirmation}" = "y"; then
	echo "Exiting from setup script..."
	exit
fi

echo "Would you like to create folders in $prefix? [y/N]"
read yes_create_folders
if ! test "${yes_create_folders}" = "y"; then
	yes_create_folders="n"
fi

echo "Would you like to clone repos to ${reposdir}? [y/N]"
read yes_clone_repos
if ! test "${yes_clone_repos}" = "y"; then
	yes_clone_repos="n"
fi

echo "Would you like to create links to ${xdgconfigdir}? [y/N]"
read yes_make_links
if ! test "${yes_make_links}" = "y"; then
	yes_make_links="n"
fi

echo "Would you like to install packages? [y/N]"
read yes_install_pkgs
if ! test "${yes_install_pkgs}" = "y"; then
	yes_install_pkgs="n"
fi

##############################
##############################
##############################

if test ${yes_create_folders} = "y"; then
	echo "Creating folders..."
	create_folders
	echo "Ok"
fi
if test ${yes_clone_repos} = "y"; then
	echo "Cloning repos..."
	clone_repos ${linuxdistro}
	echo "Ok"
fi
if test ${yes_make_links} = "y"; then
	echo "Creating symlinks for ${linuxdistro}..."
	make_links ${linuxdistro} 
	echo "Ok"
fi
if test ${yes_install_pkgs} = "y"; then
	echo "Installing packages..."
	install_packages ${linuxdistro}
	echo "Ok"
fi
