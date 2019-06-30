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

source_download() {
  echo -e "\nDownloading..."

  source_path_set
  source_tarball
  source_tarball_extract

  echo -e "\nRepository source has been successfully downloaded.\n"
}

source_path_set() {
  source_dir_create
  cd "$SOURCE_PATH"
}

source_dir_create() {
  if [ ! -d "$SOURCE_PATH" ]; then
    mkdir -p "$SOURCE_PATH"
  elif [ "$(ls -A "$SOURCE_PATH")" ]; then
    error "Source directory must be empty."
  fi
}

source_tarball() {
  local source_url=$(source_url)

  if [ -z "$source_url" ]; then
    error "Could not obtain source URL."
  fi

  curl -fL -o "$SOURCE_TARBALL" "$source_url" \
    || error "Could not obtain a downloadable source."
}

source_url() {
  local source_url=""

  if [ "$GIT_REF" != "$DEFAULT_GIT_REF" ]; then
    source_url=$(tarball_url "$GIT_REF")
  else
    source_url=$(latest_release_tarball_url)
  fi

  echo "$source_url"
}

release_url() {
  echo "$(printf "$RELEASE_URL" "$GITHUB_USERNAME" "$GITHUB_REPO" "$GIT_REF")"
}

tarball_url() {
  local git_ref="$1"

  echo "$(printf "$TARBALL_URL" "$GITHUB_USERNAME" "$GITHUB_REPO" "$git_ref")"
}

latest_release_tarball_url() {
  local release_data=$(curl -fsL "$(release_url)")
  local tarball_url=""

  if [ "$release_data" ]; then
    tarball_url=$(echo "$release_data" | grep "tarball_url")

    if [ "$tarball_url" ]; then
      tarball_url=$(echo "$tarball_url" | cut -d '"' -f 4)
    fi
  fi

  echo "$tarball_url"
}

source_tarball_extract() {
  tar -zxf "$SOURCE_TARBALL" --strip=1
  rm "$SOURCE_TARBALL"
}

deps_check() {
  local dep

  for dep in "${REQUIRED_DEPS[@]}"
  do
    if [ ! -x "$(command -v "$dep")" ]; then
      error "$(printf "Command \"%s\" was not found." "$dep")"
    fi
  done
}

read_args() {
  local i

  if [ $# -eq 0 ]; then
    usage
  fi

  for i in "$@"
  do
    case $i in
      --github_username=*)   GITHUB_USERNAME="${i#*=}";;
      --github_repo=*)       GITHUB_REPO="${i#*=}";;
      --source_path=*)       SOURCE_PATH="${i#*=}";;
      --git_ref=*)           GIT_REF="${i#*=}";;
      *)                     usage;;
    esac
  done
}

args_validation() {
  if [ -z "$GITHUB_USERNAME" ]; then
    error "Github username is missing."
  fi

  if [ -z "$GITHUB_REPO" ]; then
    error "Github repository name is missing."
  fi

  if [ -z "$SOURCE_PATH" ]; then
    error "Source download directory path is missing."
  fi
}

usage() {
  cat <<'Usage'

usage: github_repo_source_get.sh \
          --github_username=<username> \
          --github_repo=<repo> \
          --source_path=<path> \
          [--git_ref=<ref>]

  --github_username
      Github user name.

  --github_repo
      Github repository name.

  --source_path
      Github repository source download directory path.

  --git_ref
      Github repository Git reference.
      This is optional. Default: "latest".

      Acceptable values:
        * Any published release/tag name.
        * Any valid Git branch.
        * Any valid Git commit hash.
        * "latest": Latest stable published release.

Usage

  exit 0
}

error() {
  echo -e >&2 "\n$1\n"
  exit 1
}

main() {
  deps_check
  read_args "$@"
  args_validation
  source_download
}
