#
# Copyright (C) 2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU general public license,
# Version 3.  See the file COPYING for more details

#!/bin/bash

declare -r BLUECOLOR="\033[1;34;49m%s\033[m\n"                                             
declare -r REDCOLOR="\033[1;31;49m%s\033[m\n"

declare -r EASY_TEMPLATE_PATH="$HOME/.config/easy-template/templates"

function usage ()
{
  echo 'Usage: easy-template [OPTION] [p path]'
  echo -e "\t-l\tList all available templates"
  echo -e "\t-c NAME\tCreate a new template, it is expected a valid name"
  echo -e "\t-p\tTarget path to create the template. Default: current path"
  echo -e "\t-n NAME\tYou can specify a specific name for your template"
  echo -e "\t-h\tHelp information"
  exit 0
}

function list_flex_templates_available ()
{
  printf $BLUECOLOR "Available templates:"
  local -i i=1
  for available_templates in $(eval echo $EASY_TEMPLATE_PATH/*); do
    template_name=$(basename $available_templates)
    echo -e " [$i] $template_name"
    (( i++ ))
  done
}

function copy_template ()
{
  create_at=$2
  if [ -z $create_at ]; then
    create_at=$PWD
  fi
  cp -r $EASY_TEMPLATE_PATH/$1 $create_at
  printf "\t>> Template $1 copied at $create_at\n"
}

# Just execute basic control o the command option
function template_control ()
{
  local -A parameters
  local OPTIND
  while getopts "lc:p:n:h" options; do
    case $options in
      c | p | n)
        parameters[$options]=$OPTARG
      ;;
      l)
        list_flex_templates_available
				exit 0
      ;;
      h | * | \?)
        usage
      ;;
    esac
  done
  # Default operation without parameter: show templates
  if [ -z ${#parameters[@]} ]; then
    list_flex_templates_available
    exit 0
  fi

  # Handle create options
  if [ -n ${parameters["c"]} ]; then
    local copyTo=""

    if [ ${parameters["n"]} ]; then
      copyTo=${parameters["n"]}
    fi

    if [ ${parameters["p"]} ]; then
      copyTo=${parameters["p"]}
    fi

    for template in $( eval echo $EASY_TEMPLATE_PATH/* ); do
      template_name=$(basename $template)
      if [ "$template_name" == "${parameters["c"]}" ]; then
        copy_template ${parameters["c"]} $copyTo
        exit 0
      fi
    done
  fi

  # Wrong usage
  usage
}

# Command caller
function easy-template ()
{
   (>&2 template_control "$@")
}
