#!/bin/sh

VIMCONF=~/.config/vim-config
export VIMCONF

rm -rf $VIMCONF

mkdir -p $VIMCONF/share
mkdir -p $VIMCONF/share/nvim/session
mkdir -p $VIMCONF/nvim

stow --restow --target=$VIMCONF/nvim .

alias vcf='XDG_DATA_HOME=$VIMCONF/share XDG_CACHE_HOME=$VIMCONF XDG_CONFIG_HOME=$VIMCONF nvim'
