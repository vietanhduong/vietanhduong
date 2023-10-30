export ZSH="/Users/${USER}/.oh-my-zsh"

git_branch() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    echo " (${ref})"
  else
    echo ""
  fi
}

cdgr() {
  REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z $REPO_ROOT ]]; then
    echo "Error: Not a git repository (or any of the parent directories): .git" >&2
    return 1
  fi
  # If no input we can go to the root of this repo
  [[ $# -eq 0 ]] && cd $REPO_ROOT && return 0

  DST=$REPO_ROOT/$1
  # First we will test the input, if it's a directory
  # we can go to directly
  [[ -d $DST ]] && cd $DST && return 0
  # Otherwise, if the destination is a file, we can strip
  # the filename and change the directory to the output
  [[ -f $DST ]] && cd $(dirname $DST) && return 0
  # return error if no match
  echo "$DST: No such file or directory" >&2 && return 1
}


PROMPT="%F{82}%n"
PROMPT+="@"
PROMPT+='${${(%):-%m}#anhdv-}%f:%F{111}%(4~|.../%3~|%~)%f%F{13}$(git_branch)%f'
PROMPT+='$ '

export GPG_TTY=$(tty)
export EDITOR='nvim'
export PATH=/usr/local/sbin:$PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
alias vim="nvim"
alias vi="nvim"
alias zconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias tconfig="vim ~/.tmux.conf"
alias resh="exec $SHELL"
alias lg="lazygit"
alias mp="mkdir -p"
alias hs="history"
alias vc="vault-converter"
alias wk="watch kubectl"
alias vk="viddy -n1 kubectl"
alias oapp="open -a"
alias ll="exa -lag"
alias t="tmux"
alias tn="tmux new -s"
alias ta="tmux a -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
alias tka="tmux kill-session -a"
alias tkat="tmux kill-session -at"
alias ts="tmux switch -t"
alias tiga="tig --all"
alias dc="docker-compose"
alias dcu="dc up"
alias dcd="dc down"
alias dcs="dc stop"
alias tp="telepresence"
alias ktun="k tunnel"
alias ktop="k ktop"
alias cdgr='cd $(git root)'
alias todev='ssh dev'

## =============================
command_exists () {
  type "$1" &> /dev/null ;
}
## =============================

# load bash autocomplete
autoload -U +X bashcompinit && bashcompinit

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

[[ -f "${HOME}/.zsh_profile" ]] && source $HOME/.zsh_profile

