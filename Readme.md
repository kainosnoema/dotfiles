# dotfiles

zsh and git config for macOS.

```sh
git clone git@github.com:kainosnoema/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
make install   # link files and hook up ~/.zshrc and ~/.gitconfig (safe to re-run)
make update    # pull and re-install
make unlink    # remove the symlinks
```

## How it works

- `gitignore`, `githelpers`, `gemrc` and `irbrc` are symlinked into `~`, and
  `bin/git-editor` into `~/.local/bin`. An existing file is moved to
  `<file>.backup.<timestamp>` first.
- Git's editor is `bin/git-editor`: Cursor at a terminal, a no-op for agents
  and scripts so they never hang waiting on an editor.
- `~/.zshrc` and `~/.gitconfig` stay local files, because installers and
  `gh auth setup-git` write to them. `make install` adds one line at the top of
  each that loads `zshrc` / `gitconfig` from this repo.
- Machine-specific settings go in those local files, below the repo line.
  Secrets go in `~/.zshrc.local` (sourced from `~/.zshrc`) and never in this
  repo, which is public.

Work identity, in the local `~/.gitconfig`:

```ini
[includeIf "gitdir:~/code/work-*/"]
	path = ~/.gitconfig.work
```
