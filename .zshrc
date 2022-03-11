# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
export SYSTEMD_EDITOR=vim
export EDITOR=vim
export DEFAULT_USER="jess"
export TERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"
export GIT_EDITOR=vim
POWERLEVEL10K_MODE="nerdfont-complete"
ZSH_THEME="obraun"
POWERLEVEL10K_COMMAND_EXECUTION_TIME_THRESHOLD=0

POWERLEVEL10K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true
POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE_ALWAYS=true
POWERLEVEL10K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL10K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL10K_NVM_BACKGROUND="238"
POWERLEVEL10K_NVM_FOREGROUND="green"
POWERLEVEL10K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL10K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"

POWERLEVEL10K_time_background='255'
POWERLEVEL10K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL10K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL10K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL10K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs)
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status background_jobs nvm node_version history command_execution_time time)

alias lc='colorls -lA --sd'
alias cl=colorls
alias cls=clear

plugins=(archlinux
	docker
	colored-man-pages
	colorize
	command-not-found
	dirhistory
	autojump
	zsh-syntax-highlighting
	zsh-autosuggestions
	git
	asdf
	fzf
    )

source $ZSH/oh-my-zsh.sh
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

eval $(thefuck --alias)
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Autostart X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

export PATH=~/bin:$PATH
