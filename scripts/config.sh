#!/bin/bash

exec git --git-dir=$HOME/projects/dbowring/dotfiles.git --work-tree=$HOME "$@"

