# perl programming influences in term of fucntions signatures
function _help {
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

function install_package {
   local cmd=(sudo dnf install "$@")

   if ! "${cmd[@]}"; then
        echo "Failed to install: $*" >&2
        return 1
    fi

    return 0
}

function update_system {
    local cmd=(sudo dnf update)

	if ! "${cmd[@]}"; then
		echo "Failed to update system"
		return 1
	fi

    return 0
}

function remove_package {
    local cmd=(sudo dnf remove "$@")

	if ! "${cmd[@]}"; then
		echo "Failed to remove: $*" >&2
		return 1
	fi

    return 0
}
