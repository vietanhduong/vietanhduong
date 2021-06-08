export ZSH="/Users/${USER}/.oh-my-zsh"

ZSH_THEME="simple"
COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
export GPG_TTY=$(tty)
export EDITOR='vim'
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

## =============================
command_exists () {
  type "$1" &> /dev/null ;
}
## =============================


## TERAFORM
if command_exists terraform; then
  alias tf="terraform"

  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/local/bin/terraform terraform
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
  complete -F __start_kubectl k
fi

## GCLOUD
if command_exists gcloud; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

## VAULT
if command_exists vault; then
  complete -o nospace -C /usr/local/bin/vault vault
fi

