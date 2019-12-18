# config before omz is loaded:
# ZSH_THEME="gentoo"
# plugins=()
# at the end of .zshrc:
# source ~/.vim/zshrc

# mate-terminal sets this (and setting it makes the gnome keyring work)
SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

# Dont share history between sessions
unsetopt share_history

# Command aliasses
alias caja='caja "$PWD"'
alias rg="rg -S"
alias gd="git diff -- ':!package-lock.json' ':!yarn.lock'"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PYENV
export PYENV_ROOT="$HOME/software/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Don't show changes in the current dir just because there are untracked files
export DISABLE_UNTRACKED_FILES_DIRTY=true

# Use vim by default
export VISUAL=vim
export EDITOR="$VISUAL"

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
}
_gen_fzf_default_opts
