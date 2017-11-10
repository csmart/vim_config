#!/usr/bin/env bash

# Enable debug if argument passed to script
if [[ "${1}" =~ debug ]]; then
	set -x
fi

# Check for dependencies
DEPS=""
type git &>/dev/null || DEPS="  git\n"
type vim &>/dev/null || DEPS+="  vim\n"

if [[ -n "${DEPS}" ]] ; then
	echo "Please install missing dependencies:"
	echo -e "${DEPS}"
	exit 1
fi

# Fail the whole script if one part fails
set -eo pipefail
finish() {
	# shellcheck disable=SC2181
	if [[ $? -ne 0 ]]; then
		set +x
		echo -e "\nSorry, something went wrong. Try running with debug, i.e.:"
		echo -e "  ${0} --debug\n"
	fi
}
trap finish EXIT

# Directory containing the script, so that we can copy other files out
DIR="$(dirname "$(readlink -f "${0}")")"

# Get Vundle, the vim bundler
mkdir -p "${HOME}/.vim/bundle/"
if [[ -d "${HOME}/.vim/bundle/vundle/.git" ]]; then
	( cd "${HOME}/.vim/bundle/vundle"
	echo "Pulling vundle updates from GitLab"
	git remote update &>/dev/null
	git reset --hard origin/master &>/dev/null
	cd - >/dev/null )
else
	echo "Cloning vundle from GitLab"
	git clone https://github.com/gmarik/vundle.git "${HOME}/.vim/bundle/vundle" &>/dev/null
fi

# Put our vimrc in place
echo "Installing vimrc config"
cp "${DIR}/vimrc" "${HOME}/.vimrc"

# Install all the bundles specified in .vimrc
vim +PluginInstall +qall

# Advise user of overrides
cat << EOF
All done!

You can put custom settings in ~/.vimrc.local

EOF
