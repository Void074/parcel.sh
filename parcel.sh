#!/urs/bin/env bash
## Author: Void074
## Website: https://gurialabs.fly.dev
## Git: https://codeberg.org/Void074

##!!!! Enviroment Variables !!!!##
PROOT=$(dirname $(dirname $(realpath $0)))
export PROOT
cmd="$PROOT/parcel/lib/cmd.sh"
##!!! ------------------------------------------------ !!!!##

##!!!! Source in library, helpers and utility function !!!!##
source $cmd
##!!! ------------------------------------------------ !!!!##

##!!!! Main !!!!###
declare -A commands=(
  ["install"]="install_package"
  ["remove"]="remove_package"
  ["update"]="update_system"
  ["--help"]="_help"
  ["-h"]="_help"
)

function main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        echo "usage: parcel --help"
        return 1
    fi

    shift || true

    if [[ -n  "${commands[$cmd]}" ]]; then
        ${commands[$cmd]} "$@"
    else
        echo "unknown command: $cmd"
        echo "usage: parcel --help"
        return 1
    fi
}

main "$@"
##!!!! END OF MAIN !!!!##
