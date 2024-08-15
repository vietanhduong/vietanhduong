set -xg GPG_TTY $(tty)
set -xg EDITOR 'nvim'
set -U fish_user_paths $fish_user_paths /usr/local/sbin
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
set -xg USE_GKE_GCLOUD_AUTH_PLUGIN True

set -xg CLICOLOR 1
set -xg LSCOLORS ExFxBxDxCxegedabagacad

alias vim="nvim"
alias vi="nvim"
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
alias kctx="kubectx"
alias kns="kubens"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias vg="vagrant"
alias reset-gpg="gpgconf --kill gpg-agent"
alias glp="git pull && git push"
alias sd="sudo shutdown -h now"

# Minikube
alias mkk="minikube kubectl --"
alias mks="minikube start"

# omf theme default

# cdgd -- change directory to git directory
# if no input => go to the repo root
# otherwise, go to the directory
function cdgd
  set repo_root $(git rev-parse --show-toplevel 2>/dev/null)
  if test "$repo_root" = ""
     echo "Error: Not a git repository (or any of the parent directories): .git" >&2
    return 128
  end
  if test (count $argv) -eq 0
    cd $repo_root
    return 0
  end

  if test -d $argv[1]
    cd $argv[1]
    return 0
  end

  if test -f $argv[1]
    cd $(dirname $argv[1])
    return 0
  end

  echo "The path '$argv[1]' does not exit" >&2
  return 1
end


