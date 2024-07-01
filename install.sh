#!/bin/bash -e

export INSTALLED_BASE=".installed/"
export INFO=".info"
export INSTALL_SCRIPT=".install.fish"
export DEP_FILE=".deps"

# Structure:
# dotfiles/
#       -- install.sh
#       -- install.fish
#       -- .gitignore
#       -- .gitmodules
#       -- dir/
#           -- info -> Contains the command wich is expected to be run to test for existence
#           -- _install.fish
#       -- .installed/ -> effective cache for what has already been installed
#           -- $name

# Agument parsing from https://stackoverflow.com/a/29754866
# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null 
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'ERROR: `getopt --test` failed in this environment.'
    exit 1
fi

# option --output/-o requires 1 argument
# If we want multiple values to the same arg -> use it multiple times & append to a var
LONGOPTS=debug,install-file:,no-change-shell
OPTIONS=di:k

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

d=n c=y v=n outFile=-
# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -d|--debug)
            d=y
            shift
            ;;
        -k|--no-change-shell)
            c=n
            shift
            ;;
        -i|--install-file)
            export INSTALL_SCRIPT="$2"
            shift
            ;;
        # -o|--output)
        #     outFile="$2"
        #     shift 2
        #     ;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# handle non-option arguments
# if [[ $# -ne 1 ]]; then
#     echo "$0: A single input file is required."
#     exit 4
# fi

# Setup args to pass into install.fish
args=$@

if [[ $d == y ]]
then
  echo "[DEBUG MODE ENABLED]"
  args="$args -d"
  echo "change-shell: $c"
  echo "Passing args: $args"
fi

# This setup is only for ubuntu (or debian). Ensure we have apt

if ! type apt &> /dev/null
then
  echo "APT does not exist. Setup is not prepared for non-debian based repos. Exiting..."
  exit 1
fi

# Update & install all dotfiles from the appropriate submodule
# git submodule update --init --recursive
 
# Does fish shell exist? if no then install it
FISH_OK=$(dpkg-query -W -f='${Status}' "fish" 2>/dev/null | grep "install ok installed")
if [ ! type fish &> /dev/null ] || [ ! "$FISH_OK" ];
then
  echo "Fish shell does not exist. Installing it... [Requires sudo]"
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt install -y fish
  echo $(which fish) | sudo tee -a /etc/shells

  if [[ $c == y ]]
  then
    sudo chsh -s $(which fish) $(whoami)
  fi
fi

touch "$INSTALLED_BASE/fish"

cd $(dirname $0)

./install.fish $args
