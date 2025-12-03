#!/usr/bin/env bash

REPODIR="$HOME/repos"
DOTDIR="${REPODIR}/dotfiles"

mkdir --parents ${REPODIR}
git clone https://github.com/cdavieira/dotfiles ${REPODIR}

copy_package_use(){
  PKGUSEDIR="${DOTDIR}/gentoo/package.use"
  PKGS='waybar rust zathura seatd qemu pipewire os-prober mpv imv git'
  for pkg in ${PKGS}; do
    sudo cp ${PKGUSEDIR}/$pkg  /etc/portage/package.use
  done
}

sync(){
  cd ~
  sudo emerge --sync
  sudo emerge -uDNa @world
}

# OBS: might fail because of package.use conflicts
install_core_tools(){
  PKGS="\
    app-portage/gentoolkit \
    app-eselect/eselect-repository \
    app-misc/resolve-march-native \
    app-portage/pfl \
    app-portage/genlop \
    app-admin/eclean-kernel \
    net-wireless/bluez \
    media-libs/mesa \
    dev-util/vulkan-tools \
    media-libs/libva-intel-driver \
    sys-fs/ntfs3g
  "
  sudo emerge -av "${PKGS}"
}

# OBS1: might fail because of package.use conflicts
# OBS2: might fail if not all packages currently required by wlroots are installed
# OBS3: might fail if not all patches of dwl are fully functional
bootstrap_dwl(){
  PKGS="\
    sys-auth/seatd   \
    gui-apps/wmenu   \
    gui-apps/swaybg  \
    gui-apps/waybar  \
    dev-libs/wayland \
    dev-libs/wayland-protocols \
    x11-misc/xdg-utils     \
    app-misc/wayland-utils \
    dev-util/wayland-scanner   \
    media-libs/libdisplay-info \
    x11-libs/libxkbcommon \
    x11-libs/libxcb   \
    x11-libs/xcb-util-wm  \
    dev-libs/libinput \
    x11-base/xwayland \
    gui-libs/xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk \
    sys-apps/dbus   \
    sys-auth/polkit \
    gui-apps/wl-clipboard  \
    gui-apps/grim   \
    gui-apps/swappy \
    gui-apps/slurp \
    libv4l 
  "
  sudo emerge -av "${PKGS}"

  sudo rc-service seatd start
  sudo rc-update add seatd default
  sudo gpasswd -a carlos seat

  git clone https://codeberg.org/dwl/dwl ${REPODIR}
  git clone https://gitlab.freedesktop.org/wlroots/wlroots.git ${REPODIR}/dwl

  cd ${REPODIR}/dwl/wlroots
  meson setup build && ninja -C build

  cd ${REPODIR}/dwl
  patch -b ${REPODIR}/dwl/config.mk   ${DOTDIR}/dwl/patch/diff-configmk.patch
  make
  patch -b ${REPODIR}/dwl/config.h    ${DOTDIR}/dwl/patch/diff-config.patch
  patch -b ${REPODIR}/dwl/dwl.desktop ${DOTDIR}/dwl/patch/diff-desktop.patch
  patch -b ${REPODIR}/dwl/dwl.c ${DOTDIR}/dwl/patch/git-diff-dwl.patch
  make clean
  make
  sudo make install

  ln -s ${DOTDIR}/dwl/build.fish ${REPODIR}/dwl
  ln -s ${DOTDIR}/dwl/startup.sh ${REPODIR}/dwl
  ln -s ${DOTDIR}/init.sh $HOME

  sudo poweroff
}

# install the latest version of fish by masking the stable one (the stable is
# the default one, but its way to old)
install_fish(){
  sudo vim /etc/portage/package.accept_keywords/fish
  sudo vim /etc/portage/package.mask/fish
  sudo emerge -av fish
}

install_other_programs(){
  PKGS="\
    swayidle \
    swaylock \
    tlp \
    neovim \
    ripgrep \
    fd \
    bear \
    mutt \
    dunst \
    qutebrowser \
    cups \
    bear \
    blender \
    app-emulation/qemu \
    app-containers/docker \
    app-containers/docker-cli
  "
  sudo emerge -av "${PKGS}"

  sudo usermod -aG docker carlos
  sudo gpasswd -a carlos kvm

  sudo rc-update add tlp default
}

# main routine
# copy_package_use
# sync
# install_core_tools
# install_fish
# bootstrap_dwl
# install_other_programs
