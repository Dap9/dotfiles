#!/bin/env fish

function __install -d "Install zoxide"
  printf "Installing zoxide"
  pushd /tmp
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  echo "zoxide init --cmd cd fish | source" >> "$HOME/.config/fish/config.fish"
  popd
  fish_add_path "$HOME/.local/bin"
end
