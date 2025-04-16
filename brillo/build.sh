#!/usr/bin/env bash

sudo usermod -aG video carlos
cd $1
make
sudo make install
