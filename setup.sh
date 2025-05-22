#!/usr/bin/env bash

prefix=$HOME
reposdir=$prefix/repos
xdgconfigdir=$prefix/.config

# filter all packages (managed by the distro package manager) listed for installation in 'packages.yaml' ("all.[arch/gentoo].packages")
yq_cmd_pkgs_templ='
 . as $file
 | ($file.packages.system + $file.packages.user) as $allpkgs
 | ($file.all.LINUXDISTRO.install.packages.system + $file.all.LINUXDISTRO.install.packages.user) as $selectedpkgs
 | $allpkgs[] | select(.name as $n | $selectedpkgs | index($n))
 | [.LINUXDISTRO] - $file.all.LINUXDISTRO.ignore.packages
 | flatten(1)[]
'

# filter all packages (managed by non-distro package managers) listed for installation in 'packages.yaml'
yq_cmd_altpkgs_templ='
  . as $file
  | $file.all.LINUXDISTRO.install.altpackages as $altpkgs
  | $file.altpackages.METHOD[]
  | select(.name)
  | { (.name): .url }
  | .[$altpkgs[]]
'

yq_cmd_services_templ='
  . as $file
  | ($file.all.LINUXDISTRO.install.services - $file.all.LINUXDISTRO.ignore.services) as $services
  | [ $file.services[] | select(.name as $n | $services | index($n)) ]
  | map(.LINUXDISTRO)
  | flatten
  | group_by(.type)
  | map({ (.[0].type // empty): map(.name) }) 
  | add
  | .TYPE[]
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
  ln -sf ${reposdir}/dotfiles/init.sh ~
  case $1 in
    'arch')
      ln -sf ${reposdir}/dotfiles/kitty/kitty-arch.conf ${xdgconfigdir}/kitty
      ;;
    'gentoo')
      ln -sf ${reposdir}/dotfiles/kitty/kitty-gentoo.conf ${xdgconfigdir}/kitty
      ;;
    *) ;;
  esac

  if test -d ${reposdir}/code; then
	  sudo ln -sf ${reposdir}/code/all/fish/projects/auto_pull.fish /usr/local/bin/auto_pull
	  sudo ln -sf ${reposdir}/code/all/fish/projects/auto_push.fish /usr/local/bin/auto_push
	  sudo ln -sf ${reposdir}/code/all/python/projects/qtb-tabsaver/main.py /usr/local/bin/tabsaver
  fi
}

install_packages_alt(){
  local yq_distro_cmd=${yq_cmd_altpkgs_templ//LINUXDISTRO/$1}
  GIT_PKGS=$(cat packages.yaml | yq "${yq_distro_cmd//METHOD/git}" | clean_jq_output)
  CURL_PKGS=$(cat packages.yaml | yq "${yq_distro_cmd//METHOD/curl}" | clean_jq_output)
  YARN_PKGS=$(cat packages.yaml | yq "${yq_distro_cmd//METHOD/yarn}" | clean_jq_output)
  PIP_PKGS=$(cat packages.yaml | yq "${yq_distro_cmd//METHOD/pip}" | clean_jq_output)
  FLATPAK_PKGS=$(cat packages.yaml | yq "${yq_distro_cmd//METHOD/flatpak}" | clean_jq_output)
  # TODO: install cargo packages
  # TODO: ensure yarn, pip, flatpak, cargo (...) are available

  cd ${reposdir}

  for repo in $GIT_PKGS; do
    if ! test -d $repo; then
      git clone $repo
    fi
  done
  for pkg in $CURL_PKGS; do
    if ! test -f $repo; then
      curl $pkg
    fi
  done
  if [[ ! "$YARN_PKGS" =~ ^[[:space:]]*$ ]]; then
    yarn global add $YARN_PKGS
  fi
  if [[ ! "$PIP_PKGS" =~ ^[[:space:]]*$ ]]; then
    pip install $PIP_PKGS
  fi
  if [[ ! "$FLATPAK_PKGS" =~ ^[[:space:]]*$ ]]; then
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

  yq_cmd=${yq_cmd_services_templ//LINUXDISTRO/gentoo}
  SERVICES_DEFAULT=$(cat packages.yaml | yq "${yq_cmd//TYPE/default}" | clean_jq_output)

  sudo emerge -av $PKGS_ALL
  for serv in $SERVICES_DEFAULT; do
    sudo rc-update add $serv default
  done
}

install_packages_arch(){
  cd ${reposdir}/dotfiles

  local yq_cmd=${yq_cmd_pkgs_templ//LINUXDISTRO/arch}
  PKGS_ALL=$(cat packages.yaml | yq "$yq_cmd" | clean_jq_output)

  yq_cmd=${yq_cmd_services_templ//LINUXDISTRO/arch}
  SERVICES_SYSTEM=$(cat packages.yaml | yq "${yq_cmd//TYPE/system}" | clean_jq_output)
  SERVICES_USER=$(cat packages.yaml | yq "${yq_cmd//TYPE/user}" | clean_jq_output)

  sudo pacman -S $PKGS_ALL
  sudo systemctl enable $SERVICES_SYSTEM
  sudo systemctl --user enable $SERVICES_USER
}

install_packages(){
  case $1 in
    'arch') install_packages_arch ;;
    'gentoo') install_packages_gentoo ;;
    *) ;;
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

if ! command_exists yq ; then
  echo "This script depends on yq to work, but 'yq' wasn't detected in your system!"
  echo "Attempting to install 'yq' for distro "${linuxdistro}"..."
  case ${linuxdistro} in
    'arch') sudo pacman -S jq yq ;;
    'gentoo') sudo pacman -S app-misc/jq app-misc/yq ;;
    *)
      echo "Ahhh: my script does not know how to install 'yq' for distro '${linuxdistro}'. Exiting..."
      exit
      ;;
  esac
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
echo "Would you like to install the following packages? [y/N]"
echo $(cat packages.yaml | yq "${yq_cmd_pkgs_templ//LINUXDISTRO/${linuxdistro}}" | clean_jq_output)
read yes_install_pkgs
if ! test "${yes_install_pkgs}" = "y"; then
  yes_install_pkgs="n"
fi

##############################
##############################
##############################

# if test ${yes_create_folders} = "y"; then
#   echo "Creating folders..."
#   create_folders
#   echo "Ok"
# fi
# if test ${yes_make_links} = "y"; then
#   echo "Creating symlinks for ${linuxdistro}..."
#   make_links ${linuxdistro} 
#   echo "Ok"
# fi
# if test ${yes_install_pkgs} = "y"; then
#   echo "Installing packages..."
#   install_packages ${linuxdistro}
#   echo "Ok"
# fi
