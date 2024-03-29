#!/bin/env fish

function __install -d "Install ninja-build"
  printf "Installing ninja-build...\n"
  sudo apt install ninja-build -y
  return $status
end
