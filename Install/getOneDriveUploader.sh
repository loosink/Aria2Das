Download_OneDriveUploader()
{
	trap 'echo -e "Aborted, error $? in command: $BASH_COMMAND"; trap ERR; return 1' ERR
	OneDriveUploader_os="unsupported"
	OneDriveUploader_arch="unknown"
	install_path="/usr/local/bin"

	# Termux on Android has $PREFIX set which already ends with /usr
	if [[ -n "$ANDROID_ROOT" && -n "$PREFIX" ]]; then
		install_path="$PREFIX/bin"
	fi

	# Fall back to /usr/bin if necessary
	if [[ ! -d $install_path ]]; then
		install_path="/usr/bin"
	fi

	# Not every platform has or needs sudo (https://termux.com/linux.html)
	((EUID)) && [[ -z "$ANDROID_ROOT" ]] && sudo_cmd="sudo"

	#########################
	# Which OS and version? #
	#########################

	OneDriveUploader_bin="OneDriveUploader"
	OneDriveUploader_dl_ext="zip"

	# NOTE: `uname -m` is more accurate and universal than `arch`
	# See https://en.wikipedia.org/wiki/Uname
	unamem="$(uname -m)"
	case $unamem in
	*aarch64*)
		OneDriveUploader_arch="arm";;
	*64*)
		OneDriveUploader_arch="amd64";;
	*86*)
		OneDriveUploader_arch="i386";;
	*arm*)
		OneDriveUploader_arch="arm";;
	*)
		echo "Aborted, unsupported or unknown architecture: $unamem"
		return 2
		;;
	esac

	# NOTE: `uname -m` is more accurate and universal than `arch`
	# See https://en.wikipedia.org/wiki/Uname
	unameu="$(tr '[:lower:]' '[:upper:]' <<<$(uname))"
	if [[ $unameu == *LINUX* ]]; then
		OneDriveUploader_os="linux"
	else
		echo "Aborted, unsupported or unknown OS: $uname"
		return 6
	fi

	########################
	# Download and extract #
	########################

	echo "Downloading File Browser for $OneDriveUploader_os/$OneDriveUploader_arch..."
	if type -p curl >/dev/null 2>&1; then
		net_getter="curl -fsSL"
	elif type -p wget >/dev/null 2>&1; then
		net_getter="wget -qO-"
	else
		echo "Aborted, could not find curl or wget"
		return 7
	fi
	
	OneDriveUploader_file="OneDriveUploader_"$OneDriveUploader_arch"_"$OneDriveUploader_os".$OneDriveUploader_dl_ext"
	OneDriveUploader_tag="$(${net_getter}  https://api.github.com/repos/loosink/Aria2Das/releases/latest | grep -o '"tag_name": ".*"' | sed 's/"//g' | sed 's/tag_name: //g')"
	OneDriveUploader_url="https://ghproxy.com/https://github.com/loosink/Aria2Das/releases/download/$OneDriveUploader_tag/$OneDriveUploader_file"
	echo "$OneDriveUploader_url"

	# Use $PREFIX for compatibility with Termux on Android
	rm -rf "$PREFIX/tmp/$OneDriveUploader_file"

	${net_getter} "$OneDriveUploader_url" > "$PREFIX/tmp/$OneDriveUploader_file"

	echo "Extracting..."
	case "$OneDriveUploader_file" in
		*.zip)    unzip -o "$PREFIX/tmp/$OneDriveUploader_file" "$OneDriveUploader_bin" -d "$PREFIX/tmp/" ;;
		*.tar.gz) tar -xzf "$PREFIX/tmp/$OneDriveUploader_file" -C "$PREFIX/tmp/" "$OneDriveUploader_bin" ;;
	esac
	chmod +x "$PREFIX/tmp/$OneDriveUploader_bin"

	echo "Putting OneDriveUploader in $install_path (may require password)"
	$sudo_cmd mv "$PREFIX/tmp/$OneDriveUploader_bin" "$install_path/$OneDriveUploader_bin"
	if setcap_cmd=$(PATH+=$PATH:/sbin type -p setcap); then
		$sudo_cmd $setcap_cmd cap_net_bind_service=+ep "$install_path/$OneDriveUploader_bin"
	fi
	$sudo_cmd rm -- "$PREFIX/tmp/$OneDriveUploader_file"

	if type -p $OneDriveUploader_bin >/dev/null 2>&1; then
		echo "Successfully installed"
		trap ERR
		return 0
	else
		echo "Something went wrong, OneDrive Uploader is not in your path"
		trap ERR
		return 1
	fi

}

Download_OneDriveUploader
