#!/bin/bash
#
# Install dotfiles into $HOME. Safe to re-run.
#
# - Symlinks the simple files (gitignore, githelpers, gemrc, irbrc). An existing
#   regular file is moved to <file>.backup.<timestamp> first, never overwritten.
# - ~/.zshrc and ~/.gitconfig stay machine-local real files. This only adds a
#   line that sources/includes the repo version, at the top, if it's missing.

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

backup() {
  local target=$1
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv -v "$target" "$target.backup.$STAMP"
  fi
}

link() {
  local src="$DOTFILES/$1" target="$HOME/$2"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    echo "ok      $target"
    return
  fi
  backup "$target"
  ln -sfv "$src" "$target"
}

# Prepend $2 to file $1 unless a line matching $3 is already there.
prepend() {
  local file=$1 text=$2 marker=$3
  if [ -f "$file" ] && grep -qF -- "$marker" "$file"; then
    echo "ok      $file"
    return
  fi
  if [ -L "$file" ]; then
    echo "error   $file is a symlink; make it a regular file first" >&2
    return 1
  fi
  [ -f "$file" ] && cp -p "$file" "$file.backup.$STAMP"
  { printf '%s\n\n' "$text"; [ -f "$file" ] && cat "$file"; } > "$file.tmp.$STAMP"
  mv "$file.tmp.$STAMP" "$file"
  echo "updated $file"
}

link gitignore  .gitignore
link githelpers .githelpers
link gemrc      .gemrc
link irbrc      .irbrc

mkdir -p "$HOME/.local/bin"
link bin/git-editor .local/bin/git-editor

prepend "$HOME/.zshrc" \
  "# Shared config: $DOTFILES/zshrc
[ -r \"$DOTFILES/zshrc\" ] && source \"$DOTFILES/zshrc\"" \
  "source \"$DOTFILES/zshrc\""

prepend "$HOME/.gitconfig" \
  "# Shared config: $DOTFILES/gitconfig (settings below override it)
[include]
	path = $DOTFILES/gitconfig" \
  "path = $DOTFILES/gitconfig"
