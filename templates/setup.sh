#
# Copyright (C) 2017 YOURNAME  <YOUREMAIL>
#
# This source code is licensed under the GNU general public license,
# Version 3.  See the file COPYING for more details

#!/bin/bash

set -e

declare -r BLUECOLOR="\033[1;34;49m%s\033[m\n"
declare -r REDCOLOR="\033[1;31;49m%s\033[m\n"
declare -r SEPARATOR="========================================================="
declare -r APPLICATIONNAME="YOURAPPLICATIONNAME"
declare -r TARGETDIR="TARGETTOYOURDIR"
declare -r INSTALLTO="$HOME/.config/$APPLICATIONNAME"

# Print normal message (e.g info messages). This function verifies if stdout
# is open and print it with color, otherwise print it without color.
# @param $@ it receives text message to be printed.
function say()
{
  message="$@"
  if [ -t 1 ]; then
    printf $BLUECOLOR "$message"
  else
    echo "$message"
  fi
}

# Print error message. This function verifies if stdout is open and print it
# with color, otherwise print it without color.
# @param $@ it receives text message to be printed.
function complain()
{
  message="$@"
  if [ -t 1 ]; then
    printf $REDCOLOR "$message"
  else
    echo "$message"
  fi
}

function usage()
{
  say "--install   | -i   Install $APPLICATIONNAME"
  say "--uninstall | -u   Uninstall $APPLICATIONNAME"
}

function clean_legacy()
{
  say "Removing ..."
  local trash=$(mktemp -d)

  # Remove files
  if [ -d $INSTALLTO ]; then
    mv $INSTALLTO $trash
  fi

  local toDelete="$APPLICATIONNAME"
  eval "sed -i '/$toDelete/d' $HOME/.bashrc"
}

# Synchronize .vim and .vimrc with repository.
function synchronize_files()
{
  say "Installing ..."

  mkdir -p $INSTALLTO

  # Copy the script
  cp $APPLICATIONNAME.sh $INSTALLTO
  # Copy Application file
  rsync -vr $TARGETDIR $INSTALLTO

  # Add to bashrc
  echo "# $APPLICATIONNAME" >> $HOME/.bashrc
  echo "source $INSTALLTO/$APPLICATIONNAME.sh" >> $HOME/.bashrc

  say $SEPARATOR
  say "$APPLICATIONNAME installed into $INSTALLTO"
  say $SEPARATOR
}

function install_home()
{
  # First clean old installation
  clean_legacy
  # Synchronize of vimfiles
  synchronize_files
}

# Options
case $1 in
  --install | -i)
    install_home;;
  --uninstall | -u)
    clean_legacy;;
  --help | -h)
    usage;;
  *)
    complain "Invalid number of arguments"
    exit 1;;
esac
