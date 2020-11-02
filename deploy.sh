#!/usr/bin/env bash

NVIM_DIR="$HOME/.config/nvim"

# NVIM Automation
# sudo pip3 install pynvim # NeoVim Python3 Support
if [ ! -d "$NVIM_DIR" ]; then mkdir -p "$NVIM_DIR"; fi
if [ ! -d "$NVIM_DIR/snippets" ]; then mkdir -p "$NVIM_DIR/snippets"; fi
if [ ! -f "$NVIM_DIR/init.vim" ]; then ln -s $(pwd)/vim/vimrc $NVIM_DIR/init.vim; fi
if [ ! -f "$NVIM_DIR/py_header" ]; then ln -s $(pwd)/vim/py_header $NVIM_DIR/py_header; fi
if [ ! -f "$NVIM_DIR/snippets/python.snippets" ]; then ln -s $(pwd)/vim/python.snippets $NVIM_DIR/snippets/python.snippets; fi

# ZSH Aliases
if [ ! -f "$HOME/.zsh_alias" ]; then ln -s $(pwd)/zsh/zsh_alias $HOME/.zsh_alias; fi
