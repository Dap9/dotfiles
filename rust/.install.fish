#!/bin/env fish

function __install -d "Install rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
end
