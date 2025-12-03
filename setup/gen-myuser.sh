#!/usr/bin/env bash

### Username
MYUSERNAME='carlos'

### Groups
# Uncomment one of these
# GROUPS="wheel"
# GROUPS="users,wheel,audio,usb,cron"

# OBS: there are many other supplementary groups, such as: kvm,docker,seatd,...
# To add yourself to more groups later on:
# sudo usermod -aG docker $MYUSERNAME
# Or:
# sudo gpasswd -a $MYUSERNAME kvm
# Or:
# sudo groupmod -U $MYUSERNAME -a docker


### Shells
# Uncomment one of these
# MYSHELL='/usr/bin/fish'
# MYSHELL='/bin/bash'

# OBS: make sure the desired shell (ex: fish) is available in your system:
# cat /etc/shells | grep $MYSHELL

### Do it! Just do it!
useradd -m -G $GROUPS -s $MYSHELL $MYUSERNAME

# enter password
passwd $MYUSERNAME

# OBS: make sure 'vim' and 'sudo' are installed
# uncomment wheel line
EDITOR=vim visudo
