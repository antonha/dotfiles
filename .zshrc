
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit && compinit
bindkey -e
bindkey '^R' history-incremental-search-backward

alias ..='cd ..'
alias v=nvim
alias ls='ls --color=auto'

autoload colors && colors
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

export VISUAL=nvim
export EDITOR=$VISUAL
export MOZ_ENABLE_WAYLAND=1
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


case $TERM in
  (cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty*|st*|foot*|contour*)

    # Write some info to terminal title.
    # This is seen when the shell prompts for input.
    function precmd {
      print -Pn "\e]0;%~\a"
    }
    # Write command and args to terminal title.
    # This is seen while the shell waits for a command to complete.
    function preexec {
      printf "\033]0;%s\a" "$1"
    }

  ;;
esac



HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory



source <(fzf --zsh)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
