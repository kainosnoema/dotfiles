PATH=~/bin:/usr/local/bin:$PATH
export PATH

# completion
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

export GIT_PS1_SHOWDIRTYSTATE=1
. ~/.gitcompletion

complete -o default -o nospace -W \
  "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host|\
  host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)"\
  scp sftp ssh

complete -o default -o nospace -F _git g

# aliases
alias git='hub'
alias g='git'

# nvm
. ~/.nvm/nvm.sh

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export TERM=xterm-256color
export CLICOLOR=1
export EDITOR=nano
# \[\033[01;32m\]\u\[\033[00m\]:
export PS1='\[\033[01;34m\]\w$(__git_ps1 "\[\033[33m\](%s)") \[\033[00m\]\$ '
