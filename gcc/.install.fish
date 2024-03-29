#!/bin/env fish

function __install -d "Install gcc"
  printf "Installing gcc...\n"
  sudo apt install gcc -y
  return $status
end
