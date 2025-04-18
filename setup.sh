#!/usr/bin/env bash

prefix=$HOME
reposdir=$prefix/repos
xdgconfigdir=$prefix/.config

# filter all packages listed for installation in 'packages.yaml' ("all.[arch/gentoo].packages")
yq_cmd_pkgs_templ='
 . as $file
 | ($file.packages.system + $file.packages.user) as $allpkgs
 | ($file.all.LINUXDISTRO.install.packages.system + $file.all.LINUXDISTRO.install.packages.user) as $selectedpkgs
 | $allpkgs[] | select(.name as $n | $selectedpkgs | index($n))
 | [.LINUXDISTRO] - $file.all.LINUXDISTRO.ignore.packages
 | flatten(1)[]
'

# TODO: check is this is correct
yq_cmd_altpkgs_templ='
  . as $file
  | $file.all.LINUXDISTRO.install.altpackages as $altpkgs
  | $file.altpackages.METHOD[]
  | { (.name): .url }
  | .[$altpkgs[]]
'

clean_jq_output(){
  sed 's/null//g' | sort | uniq | tr -d '"' | tr '\n' ' '
}

command_exists(){
  command -v $1 &>/dev/null
  return 
}

create_folders(){
  # creating home folders
  cd $prefix
  mkdir tmp vault save repos books german txt log
  
  # creating $prefix/.config folders
  mkdir .config/{,vim,fish,kitty,tmux,waybar,qutebrowser,dunst}
  
  # creating $prefix/.cache folders
  mkdir -p .cache/vim/{,backup,swap,undo}

  cd repos
  git clone https://github.com/cdavieira/dotfiles.git
}

make_links(){
  ln -sf ${reposdir}/dotfiles/fish/config.fish ${xdgconfigdir}/fish
  ln -sf ${reposdir}/dotfiles/vim/vimrc ${xdgconfigdir}/vim
  ln -sf ${reposdir}/dotfiles/vim/snippets ${xdgconfigdir}/vim
  ln -sf ${reposdir}/dotfiles/nvim/ ${xdgconfigdir}
  ln -sf ${reposdir}/dotfiles/tmux/tmux.conf ${xdgconfigdir}/tmux
  ln -sf ${reposdir}/dotfiles/mailcap/mailcap ~/.mailcap
  ln -sf ${reposdir}/dotfiles/waybar/config.jsonc ${xdgconfigdir}/waybar
  ln -sf ${reposdir}/dotfiles/waybar/style.css ${xdgconfigdir}/waybar
  ln -sf ${reposdir}/dotfiles/dunst/dunstrc ${xdgconfigdir}/dunst
  ln -sf ${reposdir}/dotfiles/qutebrowser/config.py ${xdgconfigdir}/qutebrowser
  case $1 in
    'arch')
      ln -sf ${reposdir}/dotfiles/kitty/kitty-arch.conf ${xdgconfigdir}/kitty
      ;;
    'gentoo')
      ln -sf ${reposdir}/dotfiles/kitty/kitty-gentoo.conf ${xdgconfigdir}/kitty
      ln -sf ${reposdir}/dotfiles/gentoo/init.sh ~
      ;;
    *) ;;
  esac
}

install_packages_alt(){
  local yq_distro_cmd=${yq_cmd_altpkgs_templ//LINUXDISTRO/$1}
  GIT_PKGS=$(cat dotfiles/packages.yaml | yq "${yq_distro_cmd//METHOD/git}" | clean_jq_output)
  CURL_PKGS=$(cat dotfiles/packages.yaml | yq "${yq_distro_cmd//METHOD/curl}" | clean_jq_output)
  YARN_PKGS=$(cat dotfiles/packages.yaml | yq "${yq_distro_cmd//METHOD/yarn}" | clean_jq_output)
  PIP_PKGS=$(cat dotfiles/packages.yaml | yq "${yq_distro_cmd//METHOD/pip}" | clean_jq_output)
  FLATPAK_PKGS=$(cat dotfiles/packages.yaml | yq "${yq_distro_cmd//METHOD/flatpak}" | clean_jq_output)

  cd ${reposdir}
  for repo in $GIT_PKGS; do
    git clone $repo
  done
  for pkg in $CURL_PKGS; do
    curl $pkg
  done
  if test -n "$YARN_PKGS"; then
    yarn global add $YARN_PKGS
  fi
  if test -n "$PIP_PKGS"; then
    pip install $PIP_PKGS
  fi
  if test -n "$FLATPAK_PKGS"; then
    flatpak install $FLATPAK_PKGS
  fi
}

install_packages_gentoo(){
  cd ${reposdir}/dotfiles

  sudo cp gentoo/package.use/* /etc/portage/package.use/
  sudo cp gentoo/package.accept_keywords/* /etc/portage/package.accept_keywords/
  sudo cp gentoo/package.license/* /etc/portage/package.license/

  local yq_cmd=${yq_cmd_pkgs_templ//LINUXDISTRO/gentoo}
  PKGS_ALL=$(cat packages.yaml | yq "$yq_cmd" | clean_jq_output)
  # TODO: remove ignored services
  SERVICES_DEFAULT=$(cat packages.yaml | yq '.services.gentoo.default[]' | clean_jq_output)

  sudo emerge -av $PKGS_ALL
  for serv in $SERVICES_DEFAULT; do
    sudo rc-update add $serv default
  done
}

install_packages_arch(){
  cd ${reposdir}/dotfiles

  local yq_cmd=${yq_cmd_pkgs_templ//LINUXDISTRO/arch}
  PKGS_ALL=$(cat packages.yaml | yq "$yq_cmd" | clean_jq_output)
  # TODO: remove ignored services
  SERVICES_SYSTEM=$(cat packages.yaml | yq '.services.arch.system[]' | clean_jq_output)
  # TODO: remove ignored services
  SERVICES_USER=$(cat packages.yaml | yq '.services.arch.user[]' | clean_jq_output)

  sudo pacman -S $PKGS_ALL
  sudo systemctl enable $SERVICES_SYSTEM
  sudo systemctl --user enable $SERVICES_USER
}

install_packages(){
  case $1 in
    'arch')
      if ! command_exists yq ; then
	sudo pacman -S jq yq
      fi
      install_packages_arch
      ;;
    'gentoo')
      if ! command_exists yq ; then
	sudo pacman -S app-misc/jq app-misc/yq
      fi
      install_packages_gentoo
      ;;
    *)
      ;;
  esac
}

#################################
#################################
#################################

echo "Welcome to my setup script!"
echo "This setup script is meant to be used right after the installation of either: ArchLinux, Gentoo or another OS of my likings"
echo "Inform which distribution you are on right now:"

select linuxdistro in arch gentoo; do
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

echo "Would you like to create links to ${xdgconfigdir}? [y/N]"
read yes_make_links
if ! test "${yes_make_links}" = "y"; then
  yes_make_links="n"
fi

# TODO: add list of packages to be installed and the number of them
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
