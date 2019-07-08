# Github Downloader

Github Downloader is a shell tool that allows to download Github repositories  
sources without having to install [git](https://github.com/git/git) and cloning.

Instead, it uses [Github API](https://developer.github.com/v3/) to do that.

The tool could be useful in Docker images, where installing git might not be needed.

## Installation

Download using `curl`:
```
curl -fL -O https://raw.githubusercontent.com/akai-z/github-downloader/master/github-downloader
```

Or by using `wget`:
```
wget https://raw.githubusercontent.com/akai-z/github-downloader/master/github-downloader
```

Make the tool executable:
```
chmod +x github-downloader
```

Make the tool accessible globally:
```
sudo mv github-downloader /usr/local/bin/
```

## Usage

```
github-downloader \
    --github-username=<username> \
    --github-repo=<repo> \
    --source-path=<path> \
    [--git-ref=<ref>]
```

* `--github-username`: Github user name.

* `--github-repo`: Github repository name.

* `--source-path`: Github repository source download directory path.

* `--git-ref`: Github repository Git reference. This is optional. Default: "master".

      Acceptable git-ref values:
        * Any published release/tag name.
        * Any valid Git branch.
        * Any valid Git commit hash.
        * "latest": Latest stable published release.

## Authors

* [Ammar K.](https://github.com/akai-z)

## License

[GNU General Public License version 2](LICENSE)
