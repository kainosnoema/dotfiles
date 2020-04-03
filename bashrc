export PATH=/usr/local/bin:$PATH:~/bin

# AWS credentials
. ~/.awsrc

# Google credentials
. ~/.googlerc

# git complete
export GIT_PS1_SHOWDIRTYSTATE=1
. ~/.gitcompletion

# bash helpers
. ~/.helpers

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

code() { cd ~/Code/$1; }
_code_dirs() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local code_home=~/Code/ code_dirs="$(compgen -d ~/Code/$2 -- $cur)"
  COMPREPLY=( ${code_dirs//$code_home/} )
}
complete -o default -o nospace -o filenames -F _code_dirs code

# aliases
alias git='hub'
alias g='git'

complete -o default -o nospace -F _git g # complete for the alias

# terminal
export TERM=xterm-256color
export CLICOLOR=1
export EDITOR='subl -w'
export PS1='\[\033[01;34m\]\w$(__git_ps1 "\[\033[33m\](%s)") \[\033[00m\]\$ '
export HISTCONTROL=ignoreboth:erasedups
