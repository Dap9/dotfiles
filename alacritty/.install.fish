#!/bin/env fish

function __install -d "Install alacritty"
  printf "Installing Alacritty"
  
  # using snap else it acts weird
  # sudo snap install alacritty
  # snap has issues with `libEGL warning: MESA-LOADER: failed to open radeonsi: libLLVM-15.so.1: cannot open shared object file: No such file or directory (search paths /snap/alacritty/140/usr/lib/x86_64-linux-gnu/dri, suffix _dri)`
  sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 scdoc
  clone_branch "https://github.com/alacritty/alacritty.git" /tmp/alacritty master && \
    pushd /tmp/alacritty && \
    cargo --build --release &&
    sudo cp target/release/alacritty /usr/local/bin && \
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg && \
    sudo desktop-file-install extra/linux/Alacritty.desktop && \
    sudo update-desktop-database && \
    sudo mkdir -p /usr/local/share/man/man1 && \
    sudo mkdir -p /usr/local/share/man/man5 && \
    scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null && \
    scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null && \
    scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null && \
    scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null && \
    mkdir -p $fish_complete_path[1] && \
    cp extra/completions/alacritty.fish $fish_complete_path[1]/alacritty.fish
  
  # timeout 10s
  read -l -P 'Set alacritty as default terminal?[y/n] (Default: Yes)' confirm
  
  switch $confirm
    case N n
      return 0
  end

  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50

  set -l save_status $status
  if test $PWD != /tmp/alacritty
    return $save_status
  end

  popd
  return $save_status
end

  
