# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cesar"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Prompt
source $HOME/.profile

# User configuration

export PATH=$HOME/.anaconda/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export SPICE="$HOME/repos/spice"

export PATH="$HOME/.rbenv/bin:$PATH"
export GOPATH="$HOME/repos/golang"
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export GIN_MODE=release


# eval "$(rbenv init -)"

alias subl='open -a Sublime\ Text'
alias anarchy="curl \"http://vault.alanorozco.com/anarchy/?pinshits\" -d "
# source /usr/local/bin/virtualenvwrapper.sh
alias gspl="git stash; git pull; git stash pop;"

alias gpnb='git push -u origin $(git rev-parse --abbrev-ref HEAD)'

alias gmm="git stash; gco master; gl; gco -; git merge master && git stash pop"
alias gsp="git stash pop"
alias gs="git stash"
alias gdc="git diff --cached"
alias gl="git pull --rebase"
alias gsw="git add --all && git commit --no-verify -m 'WIP'"
alias gr="git reset"
alias grmmerged="git branch --merged master | grep -v \"\* master\" | xargs -n 1 git branch -d"

source /Users/cesar/.oh-my-git/prompt.sh

UNI=/Users/cesar/Dropbox/helsinki
alias rmr="rm -r"
alias cpr="cp -r"
alias lll="ll -tr"

alias d="docker"
alias drmtest="docker rm -f $(docker ps | grep latest | awk '{print $1}')"

unsetopt inc_append_history
unsetopt share_history

# source /usr/local/bin/virtualenvwrapper.sh
alias sayready="while true; do; say hey I am done; done;"

alias gveoo="cd $GOPATH/src/github.com/veoo/spice/services/canopener; conda activate spice-ml"
alias scratch="cd $GOPATH/src/scratch && subl ."

make_alias() {
	echo "alias $1=\"$2\"" >> ~/.zshrc
}
alias mkalias=make_alias

grep_recursive() {
	grep -r "$1" .
}

kfirstpo() {
	kubectl get po | grep  $1 | awk '{print $1}' | sed -n 1p
}

klogsof() {
	kubectl logs --tail=100 $(kgpo $1 | awk '{print $1}' | sed -n 1p)
}

gco_and_check_wip() {
	git checkout $1
	ret=$?

	if [ $ret != 0 ]; then
		return 1
	fi

	last_commit=$(git log --format=%B -n 1 -1)
	if [ "$last_commit" == "WIP" ]; then
		if [ "$(git status -s)" == "" ]; then
			echo "Restoring working in progres..."
			git reset HEAD^
		else
			echo "NOTE There's saved work in progres"
		fi
	fi
}

alias grepr=grep_recursive

alias grm="go run main.go"
alias gotest='go test -race -tags=unit $(go list ./... | grep -v '/vendor/' | grep -v kube | grep -v service-expose | grep -v cmd-configapi)'
alias gotestv='go test -race -tags=unit -v $(go list ./... | grep -v '/vendor/' | grep -v configapi | grep -v service-expose)'
alias gotestint='go test -race -tags=integration $(go list ./... | grep -v '/vendor/' | grep -v configapi | grep -v service-expose)'
alias gotestintv='go test -race -v -tags=integration $(go list ./... | grep -v '/vendor/' | grep -v configapi | grep -v service-expose)'
alias kgpo='k get po | grep '
alias kcc='kubectl config current-context'
alias kfpo=kfirstpo
alias klogs=klogsof
alias kunhealthy='kubectl get event | grep -v Normal | grep -v "[2-5].m" | grep " [a-z]\{3,\}-"'
alias gco=gco_and_check_wip
alias gcob='git checkout -b'
alias gcwip='ga .; gcmsg "WIP" --no-verify'

alias dstartkr="docker rm -f kannel_routing; HOST_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | sed -n 1p) docker run --name kannel_routing -d -p 3040:3040 -e KANNEL_USER=kannelUser -e KANNEL_PASSWORD=kannelPassword -e REDIS_URL=redis://$HOST_IP:6379 -e MYSQL_HOST=$HOST_IP -e MYSQL_PORT=4406 -e MYSQL_USER=root -e MYSQL_PASSWORD=root kannel_routing"

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/cesar/repos/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/cesar/repos/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/cesar/repos/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/cesar/repos/google-cloud-sdk/completion.zsh.inc'
fi
alias k="kubectl"
alias ks="kubectl --namespace=kube-system"
