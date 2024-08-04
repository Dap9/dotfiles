#!/bin/env fish

function __install -d "Install go"
  set go_version "1.22.5"
  printf "Installing go version: $go_version\n"
  pushd /tmp
  wget "https://go.dev/dl/go$go_version.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go$go_version.linux-amd64.tar.gz"
  popd
  fish_add_path /usr/local/go/bin
end
