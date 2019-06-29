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

release_url() {
  echo "$(printf "$RELEASE_URL" "$GITHUB_USERNAME" "$GITHUB_REPO" "$GIT_REF")"
}

tarball_url() {
  local git_ref="$1"

  echo "$(printf "$TARBALL_URL" "$GITHUB_USERNAME" "$GITHUB_REPO" "$git_ref")"
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

error() {
  echo -e >&2 "\n$1\n"
  exit 1
}
