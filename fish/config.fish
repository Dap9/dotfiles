if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

set -g fish_key_bindings fish_vi_key_bindings
set fish_cursor_insert line

zoxide init --cmd cd fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f "$HOME/mambaforge/bin/conda"
    eval "$HOME/mambaforge/bin/conda" "shell.fish" "hook" $argv | source
end

if test -f "$HOME/mambaforge/etc/fish/conf.d/mamba.fish"
    source "$HOME/tandonjayant/mambaforge/etc/fish/conf.d/mamba.fish"
end
# <<< conda initialize <<<
