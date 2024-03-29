#!/bin/env fish

function __install -d "Install build-essential"
  printf "Installing build-essential...\n"
  sudo apt install build-essential -y
  return $status
end
