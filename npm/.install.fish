#!/bin/env fish

function __install -d "Install npm"
  printf "Installing npm\n"
  sudo apt update
  sudo apt install -y npm
  return $status
end
