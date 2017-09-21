
# GitHub shorthand Alfred workflow

This Alfred 3 workflow provides easy access to GitHub repositories, issue search, local project directories, and more using a configurable shorthand.

## Installation and configuration

This repository contains the Alfred workflow. In addition, you'll need the [`gh-shorthand` command-line tool](https://github.com/zerowidth/gh-shorthand), and optionally the [`gh-shorthand-backend` RPC server](https://github.com/zerowidth/gh-shorthand-backend).

* Install the `gh-shorthand` CLI tool (see its [README](https://github.com/zerowidth/gh-shorthand#installation) for instructions)
* Download and install the `gh-shorthand.alfredworkflow` workflow from the [releases](https://github.com/zerowidth/gh-shorthand.alfredworkflow/releases) page.
* Alternately, if you want to run directly from a live repository (so you get updates, etc.), clone this repository and run `./install.sh` to symlink it into your Alfred workflow directory.
* Edit the config vars for this workflow by clicking the `[x]` in the Alfred toolbar.
    * Change `EDITOR` to your preferred editor's command-line invocation. It will be executed with a directory or filename as the first and only argument.
    * Change `GH_SHORTHAND` to the path to your `gh-shorthand` binary, either as downloaded from a release or as built from source.
* (Optional) install, configure, and start the `gh-shorthand-backend` server.

## Examples

### Shorthand expansion

Given the configuration in `~/.gh-shorthand.yml`:

```yml
default_repo: "zerowidth/gh-shorthand"
repos:
  df: "zerowidth/dotfiles"
users:
  z: "zerowidth"
```

* `gh` opens `https://github.com/zerowidth/gh-shorthand` (the default repository).
* `gh 123` opens issue 123 in the default repo `https://github.com/zerowidth/gh-shorthand/issues/123`.
* `gh df` opens `https://github.com/zerowidth/dotfiles` (repo shorthand expansion).
* `gh z/vim-bgtags` opens the `zerowidth/vim-bgtags` repo (user shorthand expansion).
* `gh github/linguist` opens the `github/linguist` repository (no shorthand expansion, full repo specified).
* `ghi df` opens `https://github.com/zerowidth/dotfiles/issues` (repo shorthand expansion).
* `ghi df foobar` searches issues in `zerowidth/dotfiles` for "foobar" (repo shorthand expansion).
* `ghn` for a new issue in a repo.
* `ghp` to list projects in a repo.
* `ghp 123` to open project #123 in the default repo.
* `gm df 123` inserts a markdown link to `zerowidth/dotfiles#123`
* `gi 123` inserts an issue reference to `zerowidth/dotfiles#123`

### Project directory completion

Given the configuration in `~/.gh-shorthand.yml`:

```yml
project_dirs:
  - "~/code"
  - "~/go/src/github.com/zerowidth"
```

And a project called `foobar` in `~code` and the `gh-shorthand` source in the `GOPATH`:

* `ghe fb` opens an editor with `~/code/foobar` (directory name matching)
* `ghe short` opens an editor with `~/go/src/github.com/zerowidth/gh-shorthand` (directory name matching).
* `ght` opens a terminal in a project directory.
* `gho` opens Finder with a project directory.

### URL conversion

Given `https://github.com/zerowidth/gh-shorthand/issues/123` on the clipboard:

* `gml` will insert a Markdown link: `[zerowidth/gh-shorthand#123](https://github.com/zerowidth/gh-shorthand/issues/123)` (useful for writing markdown not in issue or PR comments).
* `gir` will insert an issue reference: `zerowidth/gh-shorthand#123` (useful for referencing issues within GitHub comments).
* In addition to the alfred commands, the `//gml` and `//gir` snippet triggers also  convert the clipboard to Markdown links and issue references.

### Meta

* `ghc` opens an editor for `~/.gh-shorthand.yml` to configure the `gh-shorthand`  script backing this workflow. See the [`gh-shorthand` configuration](https://github.com/zerowidth/gh-shorthand#configuration) docs for more information.

## RPC annotation

If the [gh-shorthand-backend RPC server](https://github.com/zerowidth/gh-shorthand-backend) is configured and running, `ghi` (issue search/list) is augmented with live results retrieved from the GitHub API, repository and issue/PR items are annotated with their open/closed state and their title, `ghs` (global search) shows the top 20 matches, and `ghp` retrieves project lists.

Issue search is particularly useful as it allows the [full search syntax ](https://help.github.com/articles/searching-issues-and-pull-requests/), e.g. `ghi df is:open is:pr` for showing open pull requests.

RPC queries are triggered after a slight delay to prevent unnecessary queries.

## Contributing

Open an issue. The Alfred bits aren't easily shareable or modifiable like most source code is, unfortunately, so PRs might not get merged. I'm happy to consider ideas and requests, though. For anything particularly customized, you might have a better time just modifying the workflow in place.
