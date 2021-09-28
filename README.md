# GitHub shorthand Alfred workflow

This Alfred 4 workflow provides easy access to GitHub repositories, issue search, local project directories, and more using a configurable shorthand.

## Installation and configuration

This repository contains the Alfred workflow. In addition, you'll need the [`gh-shorthand` command-line tool and optional RPC server](https://github.com/zerowidth/gh-shorthand).

* Install the `gh-shorthand` CLI tool. See its [README](https://github.com/zerowidth/gh-shorthand#installation) for instructions.
* Clone this repository and run `./install.sh` to symlink it into your Alfred workflow directory.
* Edit the config vars for this workflow by clicking the `[x]` in the Alfred toolbar:
  * Change `GH_SHORTHAND` to the path to your `gh-shorthand` binary, either as downloaded from a release or as built from source. This defaults to `~/go/bin/gh-shorthand`.

The Alfred [terminal integration](https://www.alfredapp.com/help/features/terminal/) is required for the "open in terminal" action. The Alfred integration defaults to Terminal.app, and you can find iTerm configurations at [vitorgalvao/custom-iterm-scripts-for-alfred](https://github.com/vitorgalvao/custom-iterm-scripts-for-alfred).

The remainder of the configuration lives in `~/.gh-shorthand.yml`. The full configuration file documentation is in the `gh-shorthand` repository [here](https://github.com/zerowidth/gh-shorthand#configuration).

## Usage

See the [`gh-shorthand` completion documentation](https://github.com/zerowidth/gh-shorthand#completion) for the full grammar of these queries.

### Opening repositories, issues, and paths

Given the configuration in `~/.gh-shorthand.yml`:

```yml
default_repo: "zerowidth/gh-shorthand"
repos:
  df: "zerowidth/dotfiles"
users:
  z: "zerowidth"
```

* `g [user|user/repo] [issue number|/path]`: open a GitHub repository, a specific issue, and paths within repositories.
    * `g foo/bar` opens the `foo/bar` repository
    * `g z/foo` opens the `zerowidth/foo`  repository, expanding the `z` user shorthand to `zerowidth`
    * `g df` opens the `zerowidth/dotfiles` repository, expanding the `df` repo shorthand.
    * `g ` (trailing space!) opens the default repository, `zerowidth/gh-shorthand`
    * `g foo/bar#123` or `g foo/bar 123` opens issue 123 in the `foo/bar` repository
    * `g z/foo 123` opens issue 123 in the `zerowidth/foo` repository, expanding the `z` user shorthand
    * `g df 123` opens issue 123 in the `zerowidth/dotfiles` repository, expanding the `df` repository shorthand
    * `g 123` opens issue (or pull request) #123 in the default repository
    * `g foo/bar /branches` opens the default repository with the `/branches` path appended
    * `g z/foo /branches` opens the `zerowidth/foo/branches` path
    * `g df /branches` opens `zerowidth/dotfiles/branches`
    * `g /branches` opens the default repository `/branches`
* `gi [user|user/repo] [query]`: list, search, and open issues/PRs in a repository.
    * `gi foo/bar` lists the issues in the `foo/bar` repository.
    * `gi foo/bar fixes` searches the issues in `foo/bar` for "fixes".
    * `gi ` (trailing space!) lists the issues in the default repository
    * `gi fixes` searches the default repository's issues for "fixes"
    * The same shorthand expansion applies: `z/foo` becomes `zerowidth/foo`, `df` becomes `zerowidth/dotfiles`.
    * Issue search allows the [full search syntax ](https://help.github.com/articles/searching-issues-and-pull-requests/), e.g. `gi is:open is:pr` for showing open pull requests in the default repository.
* `gn [query] [title]` opens the "new issue" page with the provided title in the given repository.
    * `gn ` (trailing space!) opens the new issue page in the default repository
    * `gn fix a bug` opens the new issue page in the default repository with "fix a bug" as the issue title
    * `gn foo/bar` opens the new issue page in the `foo/bar` repository
    * User/repository shorthand expansion applies
* `gp [user|repo] [project number]` lists or shows a specific project in the given or default repository. This does not currently support project title searches.

### Opening terminals and editors locally

Given the configuration in `~/.gh-shorthand.yml`:

```yaml
project_dirs:
  ~/code
  ~/work/projects
```

And the following directory tree:

```
~
├── code
│   ├── dotfiles
│   └── demo
└── work
    └── projects
        ├── client
        └── server
```

* `ge df` opens the `dotfiles` project with the configured editor.
* `gt df` opens the terminal in the `dotfiles` directory.
* `ge wpc` opens the editor with `work/projects/client` .
* `gt wpc` opens the terminal in `work/projects/client`.

Both the `gt` and `ge` commands have single character aliases: `t` and `e` respectively.

### Links and issue references

* `gir` retrieves a GitHub URL from the clipboard, converts it to an issue reference (as used in GitHub issues), and pastes it into an active editor: `https://github.com/github/linguist/issues/1` on the clipboard becomes `github/linguist#1`
* The `gml` command retrieves a GitHub URL from the clipboard and converts it to a markdown link: `https://github.com/github/linguist/issues/1`  on the clipboard becomes `[github/linguist#1](https://github.com/github/linguist/issues/1)`
* The `gmd` command uses the RPC server backend to retrieve the issue title for the linked issue and includes it in the generated markdown link: `https://github.com/github/linguist/issues/1` becomes `[github/linguist#1: Binary detection issues on extensionless files](https://github.com/github/linguist/issues/1)`

`gml` and `gmd` understand fully qualified issue references in the clipboard: `github/linguist#1` can be converted to a markdown link without having to look up its URL first. Similarly, `gir` can parse the URL out of a markdown link if that's on the clipboard.

### Snippet expansion

Alongside the `gir`, `gml`, and `gmd` commands, this workflow supports inline snippet expansion for the same behavior with even more convenience:

* `//gir` and `//ir` insert an issue reference
* `//gml` and `//ml` insert a markdown link
* `//md` and `//md` insert a markdown link with description when RPC is enabled

### Meta

* `gc` opens an editor for `~/.gh-shorthand.yml` to make it easy to adjust the configuration. See the [`gh-shorthand` configuration](https://github.com/zerowidth/gh-shorthand#configuration) docs for more information.

### Actions

Most repository/issue Alfred results include alternate actions:

* `cmd-c` to copy the url to the result
* hold `cmd` to insert a markdown link
* hold `opt` to insert an issue reference
* hold `ctrl` to insert a markdown link including an issue description (applies when RPC is enabled)

## RPC annotation

Whenever a repository, issue, or pull request is displayed in Alfred results, and when the RPC server is enabled, the workflow retrieves and displays the repository description, issue title, and issue/PR state (open, closed, merged). When listing or searching issues in a repository, the RPC server executes that query and display results inline in Alfred. If RPC is disabled, only links to repositories, issues and search pages are displayed.

RPC queries are triggered after a slight delay to prevent unnecessary queries against the API.

## Contributing

Open an issue. The Alfred bits aren't easily shareable or modifiable like most source code is, unfortunately, so PRs might not get merged. I'm happy to consider ideas and requests, though. For anything particularly customized, you might have a better time  modifying the workflow in place.
