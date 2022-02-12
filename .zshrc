export ZSH="/Users/${USER}/.oh-my-zsh"

git_branch() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    echo " (${ref})"
  else
    echo ""
  fi
}

PROMPT='%(!.%{$fg[red]%}.%{$fg[cyan]%})%B[%*] %{$fg[green]%}%9c%{$fg[magenta]%}$(git_branch)%F{none} %{$fg[gray]%}$%b %{$reset_color%}% '

export GPG_TTY=$(tty)
export EDITOR='vim'
export PATH=/usr/local/sbin:$PATH
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
alias zconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias tconfig="vim ~/.tmux.conf"
alias resh="exec $SHELL"
alias mp="mkdir -p"
alias hs="history"
alias vc="vault-converter"
alias wk="watch kubectl"
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

alias gr="cd $(git rev-parse --show-toplevel)"

## =============================
command_exists () {
  type "$1" &> /dev/null ;
}
## =============================

# load bash autocomplete
autoload -U +X bashcompinit && bashcompinit

## TERRAFORM
if command_exists terraform; then
  alias tf="terraform"
  complete -o nospace -C /usr/local/bin/terraform terraform
fi

## TERRAGRUNT
if command_exists terragrunt; then 
  alias tg="terragrunt"
  complete -C /usr/local/bin/terraform terragrunt
fi


## AWS CLI
if command_exists aws; then
  complete -C '/usr/local/bin/aws_completer' aws
  export PATH=/usr/local/aws/bin:$PATH
fi

## KUBECTL
if command_exists kubectl; then
  export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
  
  source <(kubectl completion zsh | sed '/_bash_comp/ s/^#*/#/')
  alias k="kubectl"
  alias kctx="kubectl config use-context"
  complete -F __start_kubectl k
fi

## KUBECTX
if command_exists kubectx; then 
  alias kctx="kubectx"
  alias kns="kubens"
fi

## GCLOUD
if [ -d "/usr/local/Caskroom/google-cloud-sdk" ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

## VAULT
if command_exists vault; then
  complete -o nospace -C /usr/local/bin/vault vault
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

