#!/bin/bash
set -x

# Keep only one previous version for packages
paccache -rk1
# Don't keep any previous versions for uninstalled packages
paccache -ruk0

# Remove orphan packages
pacman -Qdtq | ifne chronic sudo pacman -Rns -
# Remove orphan packages, including cyclic dependencies
pacman -Qqd | ifne chronic sudo pacman -Rsu -

