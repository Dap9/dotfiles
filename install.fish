#!/bin/env fish

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

# if not type -q stow
#   echo "Stow does exist. Installing it... [Requires sudo]"
#   sudo apt update
#   sudo apt install -y stow
# end
#
# if not type -q tmux
#   echo "TMUX does not exist. Installing it... [Requires sudo]"
#   sudo apt install tmux
# end
#
# if not type -q nvim
#   echo "NVIM does not exist, installing it.."
# end
