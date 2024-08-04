#!/bin/env fish

function __install -d "Install alacritty"
  printf "Installing Alacritty"
  
  # using snap else it acts weird
  sudo snap install alacritty
  
  # timeout 10s
  read -l -P 'Set alacritty as default terminal?[y/n] (Default: Yes)' confirm
  
  switch $confirm
    case N n
      return 0
  end

  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
end

  
