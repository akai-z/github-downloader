# GitHub Downloader

GitHub Downloader is a shell tool that allows to download GitHub repositories  
sources without having to install Git and cloning.

Instead, it uses [GitHub API v3](https://developer.github.com/v3/) to do that.

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

To verify file (github-downloader) integrity, you will need a tool that can calculate `SHA-3-512` hash.

Here are some tools that provide that:  
* OpenSSL:
```
openssl dgst -sha3-512 github-downloader
```

* [RHash](https://github.com/rhash/RHash):
```
rhash --sha3-512 github-downloader
```

* [sha3sum](https://github.com/maandree/sha3sum):
```
sha3-512sum -l github-downloader
```

Once the hash of the current state of the file is calculated,  
you have to compare it with the hash provided by this repository ([github-downloader.sha3-512](https://raw.githubusercontent.com/akai-z/github-downloader/master/github-downloader.sha3-512)).

## Usage

```
github-downloader \
  --github-username=<username> \
  --github-repo=<repo> \
  --source-path=<path> \
  [--github-token=<token>] \
  [--git-ref=<ref>]
```

* `--github-username`: GitHub user name.

* `--github-repo`: GitHub repository name.

* `--source-path`: GitHub repository source download directory path.

* `--github-token`: GitHub access token can be used to access private repositories,  
and increase [GitHub API rate limit](https://developer.github.com/v3/#rate-limiting). A guide for creating token could be found [here](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line).  
Tokens page could be found [here](https://github.com/settings/tokens). This is optional.

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
