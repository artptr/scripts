#!/bin/bash

# Based on one-liner from http://tuxtweaks.com/2010/10/remove-old-kernels-in-ubuntu-with-one-command/

function process {
	dpkg -l linux-* | awk '/^ii/{ print $2 }' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e [0-9] | grep -E '(image|headers)' | xargs sudo apt-get $1 remove
}

process --dry-run
echo
echo -n "Current kernel: "
uname -sr

echo "Are you sure?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) process -y; break;;
		No ) exit;;
	esac
done
