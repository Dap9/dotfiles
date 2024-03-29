#!/bin/env fish

set installed_base ".installed/"
set info ".info"
set install_script ".install.fish"

function install_if_dne -d "Install if does not exist" -a dir
  # Get details of dotfiles info
  read -L name < "$dir/$info"

  # Test if already installed
  if test \( -e ".installed/$name" \) -o \( (type -q $name) $status -eq 0 \)
    touch "$installed_base$name"
    if test -n "$_flag_d"
      print_warning "$name already installed"
    end
    return 0
  end

  printf "$name does not exist. "
  install $name $dir
end

function install -d "Install program" -a program dir
  printf "Installing $program...\n"
  if test -z "$dir" 
    set -f dir "$program"
  end

  if not test -d "$dir"
    print_failure "Directory $dir does not exist"
    return 1
  end

  source $dir/$install_script

  if test $status -ne 0
    print_failure "Unable to source $dir/_install.sh"
    return $status
  end

  if not __install
    print_failure "Install of $program failed"
    return $status
  end

  touch "$installed_base$program"
  print_success "Finished installing $program"
  return 0
end

function print_success -d "Print a success msg" -a msg
    printf "[$(set_color green)SUCCESS$(set_color normal)] $msg\n"
end

function print_failure -d "Print a failure msg" -a msg
    printf "[$(set_color red)ERROR$(set_color normal)] $msg\n"
end

function print_warning -d "Print a warning msg" -a msg
    printf "[$(set_color yellow)WARN$(set_color normal)] $msg\n"
end

# No built-in dict support https://github.com/fish-shell/fish-shell/issues/390
# Ad hoc dict logic from https://stackoverflow.com/a/60191660/8672027
function set_field --argument-names dict key value
    set -g $dict'__'$key $value
end

function get_field --argument-names dict key
    eval echo \$$dict'__'$key
end

