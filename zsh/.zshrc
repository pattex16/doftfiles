#           _                 _
#  ___  ___| |____    _______| |__
# / __|/ _ \ |_  /___|_  / __| '_ \
# \__ \  __/ |/ /_____/ /\__ \ | | |
# |___/\___|_/___|   /___|___/_| |_|

tmux_user="selz"
hostname_short=$(hostname | cut -c -5)
source "$ZDOTDIR/alias"

bindkey -v
bindkey -v '^?' backward-delete-char

source ~/.config/zsh/keymap

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
_comp_options+=(globdots)
zstyle ':completion::complete:*' gain-privileges 1
autoload -Uz compinit
autoload bashcompinit
bashcompinit
compinit -d ~/.cache/zsh/zcompdump
setopt promptsubst
setopt correctall
export CORRECT_IGNORE_FILE='.*'

HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

setopt INC_APPEND_HISTORY
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
export HISTTIMEFORMAT="[%F %T] "

_call_navi() {
  local selected
  if [ -n "$LBUFFER" ]; then
    if selected="$(printf "%s" "$(navi --print --fzf-overrides '--no-select-1' --query "${LBUFFER}" </dev/tty)")"; then
      LBUFFER="$selected"
    fi
  else
    if selected="$(printf "%s" "$(navi --print </dev/tty)")"; then
      LBUFFER="$selected"
    fi
  fi
  zle redisplay
}

zle -N _call_navi


setopt autocd
stty stop undef

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
      echo -ne '\e[1 q'

    elif [[ ${KEYMAP} == main ]] ||
      [[ ${KEYMAP} == viins ]] ||
      [[ ${KEYMAP} = '' ]] ||
      [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

bindkey -s '^o' 'ra\n'
bindkey -s '^f' '$(fzf)\n'
bindkey -s '^g' '_call_navi\n'
bindkey -s '^t' 'sudo htop\n'
bindkey '^R' history-incremental-search-backward
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#PLUGINS
[ -e "/usr/share/doc/pkgfile/command-not-found.zsh" ] && source "/usr/share/doc/pkgfile/command-not-found.zsh"
source ~/.config/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-github-cli-completion.zsh

run_tmux=true

if [[ $(hostname) = "vultr" ]];
then
  set $run_tmux false
fi

if [[ $DONTUSETMUX ]];
then
  set $run_tmux false
fi

if [[ $run_tmux = true ]];
then
  if [[ -z $TMUX ]] && [[ $USER != "root" ]] ; then exec tmux; fi
fi


if [[ $USER = "root" ]] ; then
  PROMPT=' %B%F{red}%n%f%b@%B%F{blue}$hostname_short%f%b:%F{yellow}%B$(pwdShort $PWD $HOME)%b%f%# '
else
  PROMPT=' %B%F{green}%n%f%b@%B%F{blue}$hostname_short%f%b:%F{yellow}%B$(pwdShort $PWD $HOME)%b%f%# '
fi

precmd () {
  
  COLOR="#3f51b5"
  
  if [[ $(hostname) == "thinkpad" ]]; then
    COLOR="#8AB4F8"
  fi

  if [[ $USER = "root" ]]; then
    #thinkpad
    # su $tmux_user -c "tmux rename-window 'root@$hostname_short' ;tmux set-window-option window-status-current-style 'fg=black bg=red';     tmux set-window-option window-status-style 'fg=red'"
  else
    if [[ -n $TMUX ]]; then
      tmux rename-window "$(pwdShort $PWD $HOME)"
      tmux set-window-option window-status-current-style "fg=black bg=$COLOR"
      tmux set-window-option window-status-style "fg=$COLOR"
    fi
  fi
}
