#!/usr/bin/env bash

mkdir ~/.config/mutt
mkdir ~/.cache/mutt/{,tmp}
# download: https://github.com/muttmua/mutt/blob/master/contrib/mutt_oauth2.py
# mv mutt_oauth2.py to ~/.config/mutt and run it
ln -rs muttrc ~/.config/mutt
