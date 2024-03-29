#!/bin/env fish

function __install -d "Install cmake"
  printf "Installing cmake...\n"
  sudo apt install cmake -y
  return $status
end
