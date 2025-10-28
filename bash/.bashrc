# don't do anything if not interactive
#[[ $- != *i* ]] && return

# aliases 
# make ls easier to use
alias ls="ls --color=always"
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

# make QT apps listen to the QT5 theme
export QT_QPA_PLATFORMTHEME=qt5ct

# make GTK apps use wayland
export GDK_BACKEND=wayland

# for esp8266 development
export IDF_PATH=~/sdk/ESP8266_RTOS_SDK
alias idf_init="source $IDF_PATH/export.sh"

# make python stuff work
export PATH=$PATH:/home/npiscitello/.local/bin
