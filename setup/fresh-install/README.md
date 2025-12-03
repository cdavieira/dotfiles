# Fresh install
This project aims to provide a way of abstracting away the package manager of
some linux distros, as to ease the process of installing software after a fresh
install

Linux distros currently supported:
* gentoo
* arch

## Usage
```sh
./setup.sh -d gentoo -s pkgmgr -b mybuild
./setup.sh -d gentoo -s pkgmgr -g audio
./setup.sh -h
```

## Why?
Software might be organized in different ways depending on the linux distro,
for a couple of reasons:
* the software might be split in multiple packages
* each package might have a different name
* the list goes on

## How does this work?
Each distro has one or more packages associated with a software

`db.yaml` stores a list of all packages associated with most programs i use in
a per-distro basis

For example, a program such as `gpg` is stored like so:
```
    - name: gpg
      arch: gpg
      gentoo: app-crypt/gnupg
```

This means that the package to install gpg in archlinux is called `gpg` while
in gentoo is called `app-crypt/gnupg`

The thing i want to install is `gpg`. The package which stands for
`gpg` in some distro shouldn't really matter to me after a fresh install

Therefore, `install.yaml` has a list of all programs i want to install (such as
`gpg`) and `setup.sh` allows me to query the exact package(s) that should be
installed in a certain distro in order to get that package

## Anything else?
Yea

`db.yaml` does not keep track of software only installed through package
managers. It can also work with software downloaded through other sources, such
as:
* `git`
* `curl`
* `flatpak`
* the list goes on

Programs can also be grouped in sets, for example:
```
  - name: texteditor
    pkgmgr:
      - vim
      - neovim
      - fd
      - ripgrep
```
The `texteditor` is a group which includes all of those programs. When querying
for the `texteditor` group, all of its items are going to be looked up in order
to name the packages associated with them


## Why not use distro-agnostic methods to install software?
I don't really use flatpak/appimages for all programs installed in my system
for many different reasons. Honestly, one day i might lay out all the reasons
for that, but to keep it simple:
* flatpak/appimage is great, until the integration with your system doesn't
work/sandbox breaks

My system is a mix of programs installed with:
* the package manager
* git + make/cmake/meson/...
* manually with curl + scripts
* flatpak
* appimages
* other sources

So this project was my solution to deal with that mess


## Files
| File           | Description     |
| -------------- | --------------- |
| `db.yaml`      | per-distro package info + metadata |
| `install.yaml` | config / packages planned to be installed |
| `setup.sh`     | main file |
| `test.sh`      | tests for all routines found in `utils.sh` |
| `utils.sh`     | routines to leverage `jq`, use `utils.jq` and bash stuff |
| `utils.jq`     | custom functions to handle parsing the forementioned `.yaml` files |


## References
* https://jqlang.org/manual/#defining-functions
* https://jqlang.org/manual/#modules
* https://github.com/stanch/jq-modules/tree/master
* https://apihandyman.io/api-toolbox-jq-and-openapi-part-2-using-jq-command-line-arguments-functions-and-modules/
* https://stackoverflow.com/questions/53315791/how-to-convert-a-json-response-into-yaml-in-bash
* https://stackoverflow.com/questions/11742996/is-mixing-getopts-with-positional-parameters-possible
> the jq commands 'to_entries', 'from_entries' would've been pretty useful if i knew about them before writing 'utils.jq'!
