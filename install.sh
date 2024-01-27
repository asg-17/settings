#!/usr/bin/env bash

# One-liner installation for these settings
#
# curl https://raw.githubusercontent.com/asg-17/settings/master/install.sh | bash
#

main() {
  readonly settingsDir="${HOME}/.asg-17"
  readonly repo="https://github.com/asg-17/settings"

  if [[ ! "$(command -v git)" ]]; then
    echo "This bootstrap script requires git. Aborting."
    exit 1
  fi

  if [[ -d "$settingsDir" ]]; then
    echo "The settings directory (${settingsDir}) already exists. We will assume you already cloned the correct repository."
  else
    git clone --quiet --filter=blob:none "${repo}" "${settingsDir}"
  fi

  cd "${settingsDir}" || exit
  . setup.sh
}

main "$@"
