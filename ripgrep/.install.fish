#!/bin/env fish

function __install -d "Install ripgrep"
  printf "Installing ripgrep\n"
  sudo apt install ripgrep
  return $status
end
