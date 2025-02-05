#!/urs/bin/env bash
## Author: Void074
## Website: https://gurialabs.fly.dev
## Git: https://codeberg.org/Void074

declare -A commands=(
  ["install"]="install_package"
  ["remove"]="remove_package"
  ["update"]="update_system"
  ["--help"]="help"
)

function help() {
    echo "getting started"
    return 0
}

function install_package() {
   local cmd=(sudo dnf install "$@")

   if ! "${cmd[@]}"; then
        echo "Failed to install: $*" >&2
        return 1
    fi

    return 0
}

function update_system() {
    local cmd=(sudo dnf update)

		if ! "${cmd[@]}"; then
			echo "Failed to update system"
			return 1
		fi

    return 0
}

function remove_package() {
    local cmd=(sudo dnf remove "$@")

		if ! "${cmd[@]}"; then
			echo "Failed to remove: $*" >&2
			return 1
		fi

    return 0
}

function main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        echo "usage: cmds --help"
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
