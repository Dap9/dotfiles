#!/bin/env fish

function __install -d "Install stow"
  printf "Installing stow...\n"
  sudo apt install stow -y
  return $status
end
