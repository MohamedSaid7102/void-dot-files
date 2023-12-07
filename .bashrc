# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

## xbps section

alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias q='doas xbps-query -Rs'
alias r='doas xbps-remove -R'

## System aliases
alias rm="echo 'Use <backslash>rm to remove permanently, consider using trash-put'"
# alias trm="trash-put "
# alias trl="trash-list "
# alias trs="trash-restore "

alias tmuxn="tmux new -s "
alias tmuxl="tmux ls "
alias tmuxk="tmux kill-session -t "
alias tmuxa="tmux attach -t "

# some more ls aliases
alias ll='lsd -l'
alias la='ls -A'
alias l='lsd'
alias cat='bat'
alias chrome='google-chrome'
alias short="PROMPT_DIRTRIM=1"
#alias vi='$HOME/nvim.appimage'
alias vi='nvim'
# github
alias gi='git init'
alias gic='git commit -m "Initial Commit"'
alias glg='git log --graph --oneline --decorate'
alias gb='git branch'
alias gst='git status'
alias gsw='git switch '
alias gc='git commit '
alias gmd='git commit --amend --no-edit'
alias gcm='git commit -m '
alias ga='git add ' # git add
alias gaa='git add .' # git add all
alias gd='git restore *' #Discard local changes
alias ghtoken='cat $HDD/github-token.txt | xclip -selection clipboard'


# Extract file in current working direcotry
alias x='tar -xvzf'
# Extract to some working directory
alias xt='function extract_to() { tar -xvzf "$1" -C "$2"; }; extract_to'
# Make files gcc c/c++
alias m='doas make clean install'
# Apply new changes to config.def.h in Suckless.org softwares { sa => suckless apply }
alias sa='doas trash-put config.h && m'

# XDEB alias: https://github.com/toluschr/xdeb
alias xdeb='doas xdeb -Sde '

# My global envvariable "env variables"

export XDG_CONFIG_HOME=$HOME'/.config'
export HDD='/mnt/hdd'
export WEB_DEV=$HDD'/Development/webDev'
export WEB_GIT=$WEB_DEV'/a-projects/1.public-github'
export MOB_DEV=$HDD'/Development/mobileDev'
export ODC=$WEB_DEV'/ODC'
export DRCODE=$WEB_DEV'/drcode'

export BROWSER=brave-browser-nightly
export TERMINAL=st

export NNN_PLUG='j:autojump;f:finder;o:fzopen;p:preview-tui;t:preiew-tabbed;v:imgview;x:!chmod +x "$nnn"'
export NNN_FCOLORS='0000E6310000000000000000'
export NNN_OPENER='$HOME/src/suckless/nnn/plugins/nuke'
export NNN_FIFO="/tmp/nnn.fifo"

alias nnn='nnn -e'

# Applications
# export POSTMAN='$HOME/src/postman/Postman/'

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/opt/flutter/bin:$PATH"
export PATH="/home/shelf/.local/bin:$PATH"
export PATH="$PATH:/usr/bin"

eval "$(jump shell)"

#Powerline Shell
eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
