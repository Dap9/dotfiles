#!/bin/env fish

function __install -d "Install conda"
  pushd /tmp
  wget micro.mamba.pm/install.sh
  chmod +x install.sh
  ./install.sh
  popd
  eval "$(micromamba shell hook --shell fish)"
  alias -s mamba micromamba
  return $status
end 
