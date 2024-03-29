#!/bin/env fish

function __install -d "Install unzip"
  printf "Installing unzip...\n"
  sudo apt install unzip -y
  return $status
end
