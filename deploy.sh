#!/usr/bin/env bash

# VIM Automation
mkdir -p $HOME/.vim/snippets
ln -s $(pwd)/vim/vimrc $HOME/.vimrc
ln -s $(pwd)/vim/py_header $HOME/.vim/py_header
ln -s $(pwd)/vim/python.snippets $HOME/.vim/snippets/python.snippets
