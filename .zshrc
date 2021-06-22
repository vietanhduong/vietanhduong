export ZSH="/Users/${USER}/.oh-my-zsh"

git_branch() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    echo " (${ref})"
  else
    echo ""
  fi
}

PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%B[%*] %{$fg[yellow]%}%9c$(git_branch)%F{none} %{$fg[green]%}$%b %{$reset_color%}% '
export TERM="xterm-256color"
export GPG_TTY=$(tty)
export EDITOR='vim'
export PATH=/usr/local/sbin:$PATH
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
alias zconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias tconfig="vim ~/.tmux.conf"
alias ls="ls -lGah"
alias reshell="exec $SHELL"
alias hs="history"

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
if [ -d "/usr/local/Caskroom/google-cloud-sdk" ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

## VAULT
if command_exists vault; then
  complete -o nospace -C /usr/local/bin/vault vault
fi


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

