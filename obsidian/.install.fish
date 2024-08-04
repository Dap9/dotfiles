#!/bin/env fish

function __install -d "Install obsidian"
  set obsidian_url "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb" 
  set install_file (basename "$obsidian_url")
  pushd /tmp
  wget -O "$install_file" "$obsidian_url"
  sudo dpkg -i "./$install_file"
  popd
end
