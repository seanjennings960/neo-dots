#!/bin/bash

CURR_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE}")")
source "${CURR_DIR}"/activate


function help () {
	cat << EOM
Install Neovim scripts to 
USAGE: install.sh [-ch]

-c 	Clean the existing configuration
-h	Display this help message
EOM
}


while getopts "hc" option; do
	case $option in
		c) 
		clean=true;;
		h) help
		exit;;
		\?) echo Error Invalid option $option
		   exit -1;;
	esac
done

if [ ! -z "${clean}" ]; then
	rm -rf $NVIM_DIR
	echo "Cleaning current directory"
fi

mkdir -p $NVIM_DIR/share
mkdir -p $NVIM_DIR/nvim

stow --restow --target=$NVIM_DIR/nvim nvim/
