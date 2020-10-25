export LANG="en_US.UTF-8"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jess/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

ZSH=/usr/share/oh-my-zsh/
WEBSTORM=/home/jess/Applications/Webstorm/

export DEFAULT_USER="jess"
export TERM="xterm-256color"
export ZSH=/usr/share/oh-my-zsh
export GIT_EDITOR=vim
export GUPY_DEV_CLI_DIR="/home/jess/Projects/work/undefined/backend/gupy-dev-cli"
POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"
#POWERLEVEL9K_FOLDER_ICON=""
#POWERLEVEL9K_HOME_SUB_ICON="$(print_icon "HOME_ICON")"
#POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_NVM_BACKGROUND="238"
POWERLEVEL9K_NVM_FOREGROUND="green"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"

POWERLEVEL9K_TIME_BACKGROUND='255'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs nvm node_version history command_execution_time time)
POWERLEVEL9K_SHOW_CHANGESET=true
alias cls=clear

#COMPLETION_WAITING_DOTS="true"
# /!\ do not use with zsh-autosuggestions

plugins=(archlinux
	docker
	colored-man-pages
	colorize
	command-not-found
	dirhistory
	autojump
	zsh-syntax-highlighting
	zsh-autosuggestions
	git)
# /!\ zsh-syntax-highlighting and then zsh-autosuggestions must be at the end

source $ZSH/oh-my-zsh.sh
source $WEBSTOSM/bin

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]='bold'

ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'


ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
echo "Setting node to gupy needed version"
nvm use gupy
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export DENO_INSTALL="/home/jess/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
source /usr/bin/virtualenvwrapper.sh
