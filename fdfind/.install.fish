#!/bin/env fish

function __install -d "Install fdfind"
  sudo apt install fd-find
  ln -s $(which fdfind) ~/.local/bin/fd
  fish_add_path "$HOME/.local/bin"
  return $status
end
