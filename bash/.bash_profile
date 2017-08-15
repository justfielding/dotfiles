##-----------------------------------------------------------------------------
## file:         ~/.bash_profile
## author:       fielding johnston - http://www.justfielding.com
##----------------------------------------------------------------------------

# Load ~/.profile regardless of shell version
if [ -e "$HOME"/.profile ] ; then
  . "$HOME"/.profile
fi

if [ -d "$HOME"/.bash_profile.d ]; then
  for bash_profile in "$HOME"/.bash_profile.d/*.sh; do
    if [[ -e $bash_profile ]]; then
      source "$bash_profile"
    fi
  done
  unset -v bash_profile
fi

# History Settings
export HISTCONTROL=ignoredups
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"
shopt -s histappend         # append to (not overwrite) the history file
shopt -s cmdhist            # save multi-line commands in history as single line

shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob         # pathname expansion will be treated as case-insensitive

set -o vi                   # set vi-style command line editing

### Additional sources

# Iterm2 shell integration
if [ -f /Users/fielding/.iterm2_shell_integration.bash ]; then
	source /Users/fielding/.iterm2_shell_integration.bash;
fi

# For Travis gem
[ -f /Users/fielding/.travis/travis.sh ] && source /Users/fielding/.travis/travis.sh


# rbenv setup
if [[ "$(type -P rbenv)" && ! "$(type -t _rbenv)" ]]; then
  eval "$(rbenv init -)"
fi

# go version manager
[[ -s "/home/fielding/.gvm/scripts/gvm" ]] && source "/home/fielding/.gvm/scripts/gvm"

# let luarocks setup suitable env variables for us
eval $(luarocks path --bin)


### Completions

if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion";
fi
# local:lib for perl modules
eval "$(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib)"

## Platform Specific

case $(uname -s) in
  Darwin|FreeBSD)
    export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007";[ "$PWD" -ef "$HOME" ] || fdb -a "$PWD"'

    # use gdircolors and gls from homebrew's coreutilities for pretty ls output
    eval $(dircolors -b ~/.dir_colors)
    alias ls="ls --color=always -hF"

    # TODO: Figure out a way to incorporate the following alias/command/ifunction
    # colourify `alias ls |awk -F "'" '{print $2}'` -al ~

    # Generic Colourizer
    grc_resource="$(brew --prefix)/etc/grc.bashrc"
    [[ -f $grc_resource ]] && source "$grc_resource"

    if [[ $(command -v colourify) ]]; then
      alias ps='colourify ps'
      alias dig='colourify dig'
      alias mount='colourify mount'
      alias df='colourify df'
      alias cal='colourify cal'
      alias curl='colourify curl'
      alias colorJSON='colourify python -m json.tool'
    fi
  ;;
  Linux)

    # TODO: PYTHONPATH do I need to uncomment the line below?
    # export PYTHONPATH=$HOME/.local/lib/python3.4/site-packages
    # TODO: Do I need to worry about PROMPT_COMMAND on linux machines?
    # TODO: still using keychain?
    # Keychain alias (autostarting it causes SLIM to hang)
    # alias keychain_start='eval `keychain --eval --agents ssh id_rsa`'

    # Keychain alias (autostarting it causes SLIM to hang)
    alias keychain_start='eval `keychain --eval --agents ssh id_rsa`'

    # use dircolors for pretty ls output
    eval $(dircolors -b ~/.dir_colors)
    alias ls="ls --color=always -hF"
    ;;
  NetBSD|OpenBSD)
    alias ls="ls -hf"
  ;;
esac

eval "$(thefuck --alias fuck)"