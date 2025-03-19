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
    echo "Parcel - A simple cli wrapper around the basic dnf commands"
    echo "Author: Void074"
    echo "Repo: https://codeberg.org/Void074"
    echo "Version: 0.0.0-beta"
    echo ""
    echo "Usage: parcel [command]"
    echo ""
    echo "Command           Description"
    echo "install [args]    Install a package or a list of packages"
    echo "update            Syncs and updates systems"
    echo "remove [args]     Uninstall a package or list of packages"
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
