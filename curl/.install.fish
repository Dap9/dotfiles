#!/bin/env fish

function __install -d "Install curl"
  printf "Installing curl...\n"
  sudo apt install curl -y
  return $status
end
