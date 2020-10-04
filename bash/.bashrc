# don't do anything if not interactive
#[[ $- != *i* ]] && return

# aliases 
# make ls easier to use
alias ll="ls -hal"

# easy sudo editing
alias svim="sudoedit"

# environment variables
# make GPG play nice with Git
export GPG_TTY=$(tty)

# tweak 'ls' colors for my solarized terminal theme
export LS_COLORS=$LS_COLORS:'ow=1;34;107:'

# tell everyone we like VIM
export EDITOR=vim

# make QT apps use wayland
export QT_QPA_PLATFORM=wayland

# for esp8266 development
export IDF_PATH=~/sdk/ESP8266_RTOS_SDK
alias get_idf="source $IDF_PATH/export.sh"
