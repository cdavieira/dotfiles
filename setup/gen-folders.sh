#!/usr/bin/env bash

DISTRO="gentoo"
PREFIX=""
HOMEDIR="${PREFIX}${HOME}"
DOTDIR="${HOMEDIR}/repos/dotfiles"
XDGCONFIGDIR="${HOMEDIR}/.config"

mkdir --parents ${HOMEDIR}/{tmp,vault,save,repos,books,german,txt,log}
mkdir --parents ${HOMEDIR}/.config/{,vim,fish,kitty,tmux,waybar,qutebrowser,dunst,sway}
mkdir --parents ${HOMEDIR}/.cache ${HOMEDIR}/.cache/vim/{,backup,swap,undo}

ln -sf ${DOTDIR}/fish/config.fish      ${XDGCONFIGDIR}/fish
ln -sf ${DOTDIR}/vim/vimrc             ${XDGCONFIGDIR}/vim
ln -sf ${DOTDIR}/vim/snippets          ${XDGCONFIGDIR}/vim
ln -sf ${DOTDIR}/nvim/                 ${XDGCONFIGDIR}
ln -sf ${DOTDIR}/tmux/tmux.conf        ${XDGCONFIGDIR}/tmux
ln -sf ${DOTDIR}/mailcap/mailcap       ${HOMEDIR}/.mailcap
ln -sf ${DOTDIR}/waybar/config.jsonc   ${XDGCONFIGDIR}/waybar
ln -sf ${DOTDIR}/waybar/style.css      ${XDGCONFIGDIR}/waybar
ln -sf ${DOTDIR}/dunst/dunstrc         ${XDGCONFIGDIR}/dunst
ln -sf ${DOTDIR}/qutebrowser/config.py ${XDGCONFIGDIR}/qutebrowser
ln -sf ${DOTDIR}/sway/config           ${XDGCONFIGDIR}/sway
ln -sf ${DOTDIR}/init.sh ~

case "${DISTRO}" in
  'arch')
    ln -sf ${DOTDIR}/kitty/kitty-arch.conf   ${XDGCONFIGDIR}/kitty/kitty.conf
    ;;
  'gentoo')
    ln -sf ${DOTDIR}/kitty/kitty-gentoo.conf ${XDGCONFIGDIR}/kitty/kitty.conf
    ;;
  *) ;;
esac

#  if test -d "$1/code"; then
#    sudo ln -sf $1/code/all/fish/projects/auto_pull.fish /usr/local/bin/auto_pull
#    sudo ln -sf $1/code/all/fish/projects/auto_push.fish /usr/local/bin/auto_push
#    sudo ln -sf $1/code/all/python/projects/qtb-tabsaver/main.py /usr/local/bin/tabsaver
#  fi
#
#  if test -d /etc/greetd; then
#    sudo ln -sf $1/dotfiles/greetd/config.toml  /etc/greetd
#    sudo ln -sf $1/dotfiles/greetd/dwl.sh       /etc/greetd
#    sudo ln -sf $1/dotfiles/greetd/guigreet.sh  /etc/greetd
#    sudo ln -sf $1/dotfiles/greetd/regreet.toml /etc/greetd
#  fi
