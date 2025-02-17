set -xg GPG_TTY $(tty)
set -xg EDITOR nvim
set -U fish_user_paths $fish_user_paths /usr/local/sbin
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
set -xg USE_GKE_GCLOUD_AUTH_PLUGIN True
set -xg CONFIG_DIR $HOME/.config

# disable greeting message
set -g fish_greeting

alias v="nvim"
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
alias tiga="tig --all"
alias dc="docker-compose"
alias dcu="dc up"
alias dcd="dc down"
alias dcs="dc stop"
alias tp="telepresence"
alias k="kubectl"
alias ktun="k tunnel"
alias ktop="k ktop"
alias kctx="kubectx"
alias kns="kubens"
alias vg="vagrant"
alias reset-gpg="gpgconf --kill gpg-agent"
alias glp="git pull && git push"
alias sd="sudo shutdown -h"
alias todev='ssh dev.local'

alias tg="terragrunt"
alias tf="terraform"

# Minikube
alias mkk="minikube kubectl --"
alias mks="minikube start"

# Git
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias ga="git add"
alias gb="git branch"
alias gco="git checkout"
alias gc="git commit"
alias grb="git rebase"
alias gap="git add -p"

if test -d $HOME/go/bin
  fish_add_path $HOME/go/bin
end

# color
set -U fish_color_command green
set -U fish_color_param white

# binding
bind \cx\ce edit_command_buffer

# brew setup
if test -d /home/linuxbrew/.linuxbrew # Linux
	set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
	set -gx HOMEBREW_CASKROOM "$HOMEBREW_PREFIX/Caskroom"
else if test -d /opt/homebrew # MacOS
	set -gx HOMEBREW_PREFIX "/opt/homebrew"
	set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
	set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
	set -gx HOMEBREW_CASKROOM "$HOMEBREW_PREFIX/Caskroom"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin";
! set -q MANPATH; and set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
! set -q INFOPATH; and set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;

# cargo
if test -f $HOME/.cargo/env.fish
  source "$HOME/.cargo/env.fish"
end

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

function app_id --description "Apple Bundle ID"
  # return error if current os is not Darwin
  if test (uname) != "Darwin"
    echo "Error: This function is only available on macOS" >&2
    return 1
  end

  if test (count $argv) -eq 0
    echo "Usage: app_id <app_name>" >&2
    return 1
  end

  set app_name $argv[1]
  osascript -e "id of app \"$app_name\""
end

#
# customize fish prompt
#
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    set -l vcs_color (set_color brpurple)
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '$'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $vcs_color(fish_vcs_prompt) $normal " "$prompt_status " " $suffix " "
end


#
# vpn
#
function vpn
  if not test -f /etc/systemd/system/enable-vpn.service
    echo "No VPN service set up!" >&2
    return 1
  end
  set arg
  if test (count $argv) -ne 0
    set arg $argv[1]
  end

  switch $arg
    case stop
      sudo service enable-vpn stop
    case status
      sudo systemctl status enable-vpn status
    case '*'
      sudo service enable-vpn start
  end
end


function pbcopy -d "pbcopy over SSH"
    function on_error --on-event fish_postexec
        if test $status -ne 0
            exit 1
        end
    end

    if test -n "$SSH_TTY"
        nc -q1 localhost 2224
    else if test (uname) = "Darwin"
        /usr/bin/pbcopy
    else
        xsel --clipboard --input
    end
end

function pbpaste -d "pbpaste over SSH"
    function on_error --on-event fish_postexec
        if test $status -ne 0
            exit 1
        end
    end

    if test -n "$SSH_TTY"
        nc -q1 -d localhost 2225
    else if test (uname) = "Darwin"
        /usr/bin/pbpaste
    else
        xsel --clipboard --output
    end
end


# Tmux functions
function _build_tmux_alias
  set alias_name $argv[1]
  set tmux_cmd $argv[2]
  set ts_flag $argv[3]
  set full_cmd "command tmux $tmux_cmd $ts_flag"

  eval "
  function $alias_name --wraps='$full_cmd' --description 'alias $alias_name=$full_cmd'
      # check if the first argument for this function is empty or starts with '-'
      if test (count \$argv) -eq 0 || test (string sub -l 1 \$argv[1]) = '-'
          command tmux $tmux_cmd \$argv
      else
          $full_cmd \$argv
      end
  end
  "
end

alias t="tmux"
alias tksv="command tmux kill-server"
alias tl="command tmux list-sessions"

alias tmuxconf="$EDITOR $fish_tmux_config"
# `-t` and `-s` flag for tmux commands require argument
# so we remove the flag when called without argument and run normally when called with argument
# see: https://github.com/ohmyzsh/ohmyzsh/issues/12230
_build_tmux_alias "ta" "attach" "-t"
_build_tmux_alias "tad" "attach -d" "-t"
_build_tmux_alias "ts" "switch" "-t"
_build_tmux_alias "tn" "new-session" "-s"
_build_tmux_alias "tkss" "kill-session" "-t"

functions -e _build_tmux_alias # remove this function after use


