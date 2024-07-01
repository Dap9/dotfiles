#!/bin/env fish

#TODO: MAJOR problem: Don't want to have deps as separate folders if they aren't something
# that needs configuration
# How to decide?
#
# Options:
#  - have a function to install deps in _install.fish -> installs all deps
#  issue: How to check if already installed? installed/.dep-name ?
#  custom check for the dep? version prereqs? .dep-name + version no.

argparse "h/help" "d/debug" -- $argv
set -g _flag_d $_flag_d

if test -n "$_flag_d"
  printf "Received args: $argv\n"
end

mkdir -p ".installed"

source functions.fish "$_flag_d"

if test (count $argv) -gt 0
  for arg in $argv
    install $arg
  end
  exit 0
end

# Go through all dirs excluding \..* & '.'
for dir in (find . -maxdepth 1 -type d -not -path "*/.*" -not -name ".")
  install_if_dne $dir
end
