#!/bin/sh

set -Eeuo pipefail

readonly REPO_BASE_URL="https://api.github.com/repos/%s/%s"
readonly RELEASE_URL="${REPO_BASE_URL}/releases/%s"
readonly TARBALL_URL="${REPO_BASE_URL}/tarball/%s"
readonly DEFAULT_GIT_REF="latest"
readonly SOURCE_TARBALL="github-repo-source.tar.gz"
readonly REQUIRED_DEPS=("curl" "tar" "gzip")

GITHUB_USERNAME=""
GITHUB_REPO=""
GIT_REF=$DEFAULT_GIT_REF
SOURCE_PATH=""

deps_check() {
  local dep

  for dep in "${REQUIRED_DEPS[@]}"
  do
    if [ ! -x "$(command -v "$dep")" ]; then
      error "$(printf "Command \"%s\" was not found." "$dep")"
    fi
  done
}

error() {
  echo -e >&2 "\n$1\n"
  exit 1
}
