ZSH_THEME="crunch"
COMPLETION_WAITING_DOTS="true"
export EDITOR='vim'
plugins=(git autojump git-flow-completion)
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export GOPATH=$HOME/Code/go
PATH=$PATH:$GOPATH/bin

ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# run rspec with bundle exec preprended
alias brspec="bundle exec rspec"

# docker
eval `docker-machine env 2>/dev/null`

export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
