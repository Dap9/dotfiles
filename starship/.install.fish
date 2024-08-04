#!/bin/env fish

function __install -d "Install starship"
  printf "Installing Starship"

  cargo install starship

  echo "starship init fish | source" >> "$HOME/.config/fish/config.fish"
end
