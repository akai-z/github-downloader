# GitHub Downloader

GitHub Downloader is a shell tool that allows to download GitHub repositories  
sources without having to install Git and cloning.

Instead, it uses [GitHub REST API](https://docs.github.com/en/rest) to do that.

The tool could be useful in Docker images, where installing Git might not be needed.

## Does the tool support specific files or directories download?

Currently the tool does not support specific files or directories download.

## Does the tool support Git submodules download?

Currently the tool does not support Git submodules download.

## Requirements

* curl (Used for GitHub API connection and GitHub repositories download.)

## Installation

Download using `curl`:
```
curl -fL -O https://raw.githubusercontent.com/akai-z/github-downloader/master/github-downloader
```

Or by using `wget`:
```
wget https://raw.githubusercontent.com/akai-z/github-downloader/master/github-downloader
```

Optionally, you could verify file integrity before using it. (Recommended)  
Check [file integrity verification](#file-integrity-verification) section for more details.

Make the tool executable:
```
chmod +x github-downloader
```

Make the tool globally accessible:
```
sudo mv github-downloader /usr/local/bin/
```

## File Integrity Verification

To verify file [github-downloader](github-downloader) integrity:

Compute the [SHA-256](https://en.wikipedia.org/wiki/SHA-2) hash value of the file using
a program like [sha256sum](https://www.gnu.org/software/coreutils/manual/html_node/sha2-utilities#sha2-utilities):
```
sha256sum github-downloader
```

Once the hash value of the current state of the file is computed,  
it should be compared with the one included in this repository ([github-downloader.sha2](https://raw.githubusercontent.com/akai-z/github-downloader/master/github-downloader.sha2)).

## Usage

```
github-downloader \
  --github-username=<username> \
  --github-repo=<repo> \
  --source-path=<path> \
  [--github-token] Or [--github-token=<token>] \
  [--git-ref=<ref>]
```

* `--github-username`: GitHub user name.

* `--github-repo`: GitHub repository name.

* `--source-path`: GitHub repository source download directory path.

* `--github-token`: GitHub access token can be used to access private repositories,  
and increase [GitHub API rate limit](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting). A guide for creating tokens could be found [here](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).  
Tokens settings page could be found [here](https://github.com/settings/tokens). This is optional.  
The token can be prompted for user input in a shell  
if it's a flag (`--github-token`) without a value (Recommended).  
Or it can be provided through the command as an argument with a value (`--github-token=<token>`).

* `--git-ref`: GitHub repository Git reference. This is optional. Default: "master".  
(It is required, if the default reference is not found.)

      Acceptable git-ref values:
        * Any published release/tag name.
        * Any valid Git branch.
        * Any valid Git commit hash.
        * "latest": Latest stable published release.

## Authors

* [Ammar K.](https://github.com/akai-z)

## License

[GNU General Public License version 2](LICENSE)
