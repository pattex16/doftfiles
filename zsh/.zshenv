#!/bin/zsh

source "$HOME/.config/zsh/.zprofile"
[ -e "$HOME/.local/privatenv" ] && source "$HOME/.local/privatenv"

export PATH=$PATH:$HOME/.local/bin/script:$HOME/.local/bin/joke:$HOME/.gem/ruby/3.0.0/bin

export HISTFILE="$HOME/.cache/zsh/history"
export LESS_TERMCAP_mb=$'\E[02;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESSHISTFILE="$HOME/.cache/less/less.hist"

export FLOATING=false

# export ZDOTDIR="$HOME/.config/zsh"
export NODE_PATH="$HOME/.local/share/node"
export NODE_REPL_HISTORY="$HOME/.cache/node/history"
export PYLINTHOME="$HOME/.cache/pylint"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

export RUSTUP_HOME="$HOME/.config/rustup"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GNUPGHOME="$HOME/.config/gnupg"
export WGETRC="$HOME/.config/wget/wgetrc"
export CARGO_HOME="$HOME/.local/share/cargo"
export ANDROID_SDK_HOME="$HOME/.local/share/android"
export ANDROID_AVD_HOME="$HOME/.local/share/android"
export ANDROID_EMULATOR_HOME="$HOME/.local/share/android"
export ANDROID_VENDOR_KEY="$HOME/.local/share/android"
export ERRFILE="$HOME/.cache/xorg/xsession-errors"
export HISTFILE="$HOME/.cache/bash/bash.hist"
export ICEAUTHORITY="$HOME/.cache/libice/iceauthority"
# export XAUTHORITY="$HOME/.config/xorg/xauthority"
export IPYTHONDIR="$HOME/.config/ipython"
export JUPYTER_CONFIG_DIR="$HOME/.config/jupyter"

