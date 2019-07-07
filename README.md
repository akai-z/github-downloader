# Github Downloader

Github Downloader is a shell tool that allows to download Github repositories  
sources without having to install [git](https://github.com/git/git) and cloning.

Instead, it uses [Github API](https://developer.github.com/v3/) to do that.

The tool could be useful in Docker images, where installing git might not be needed.

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

      Acceptable values:
        * Any published release/tag name.
        * Any valid Git branch.
        * Any valid Git commit hash.
        * "latest": Latest stable published release.

## Authors

* [Ammar K.](https://github.com/akai-z)

## License

[GNU General Public License version 2](LICENSE)
