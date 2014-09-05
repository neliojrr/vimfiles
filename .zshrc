#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias l1='tree --dirsfirst -ChFL 1'
alias gst='git status'

# Ruby Settings
alias bi='bundle install --path .vendor'
alias be='bundle exec'

PATH="/usr/local/heroku/bin:$PATH"
export PATH=$PATH:$HOME/bin

# added by travis gem
[ -f /Users/salvianoo/.travis/travis.sh ] && source /Users/salvianoo/.travis/travis.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
