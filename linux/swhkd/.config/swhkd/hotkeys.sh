#!/usr/bin/env bash

killall swhks

swhks & pkexec swhkd -c $HOME/.config/swhkd/swhkdrc
