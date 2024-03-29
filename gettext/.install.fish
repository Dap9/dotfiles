#!/bin/env fish

function __install -d "Install gettext"
  printf "Installing gettext...\n"
  sudo apt install gettext -y
  return $status
end
