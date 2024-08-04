#!/bin/env fish

function __install -d "Install ca-certificates"
  printf "Installing ca-certificates"
  sudo apt install ca-certificates
end
