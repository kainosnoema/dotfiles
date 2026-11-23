# Shared zsh config.
#
# Sourced from ~/.zshrc, which stays a machine-local file so installers (mise,
# bun, OrbStack, ...) can append to it without touching this repo. Secrets go
# in ~/.zshrc.local, never here: this repo is public.

DOTFILES=${${(%):-%x}:A:h}

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history hist_ignore_all_dups hist_ignore_space hist_reduce_blanks share_history

# Line editing
bindkey -e
setopt auto_cd interactive_comments

# Completion (includes git completion for `git` and the `g` alias)
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# Prompt: ~/path(branch*) $
#   * = unstaged changes, + = staged changes
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b%u%c)%f'
zstyle ':vcs_info:git:*' actionformats '%F{yellow}(%b|%a%u%c)%f'
precmd_functions+=(vcs_info)
setopt prompt_subst
PROMPT='%B%F{blue}%~%f%b${vcs_info_msg_0_} %(!.#.$) '

# Jump to a project: `code kite` -> cd ~/code/kite (with completion)
code() { cd ~/code/$1 }
_code() { _path_files -W ~/code -/ }
compdef _code code

# Aliases
alias g='git'

# Environment
export CLICOLOR=1
export EDITOR='cursor --wait'
export VISUAL=$EDITOR

# Helpers (explain, ...)
source "$DOTFILES/helpers"
