#!/bin/env fish


function __install -d "Install nerd fonts"
  set _font_list \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/ShareTechMono.zip"

  mkdir -p "$HOME/.fonts"

  pushd "/tmp"
  for font in "$_font_list"
    set name (basename "$font")
    set dirname (basename $name .zip)
    echo "Installing $name..."
    wget "$font"
    # mkdir -p "$dirname"
    unzip "$name" -d "$dirname"
    ls "$dirname/*.ttf"
    ls "$dirname"
    cp "$dirname/"*.ttf "$HOME/.fonts"
  end
  popd
  fc-cache -fv
end
