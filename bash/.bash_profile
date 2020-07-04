# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# make ls easier to use
alias ll="ls -hal"

# make GPG play nice with Git
export GPG_TTY=$(tty)

# tweak 'ls' colors for my solarized terminal theme
export LS_COLORS=$LS_COLORS:'ow=1;34;107:'

# tell everyone we like VIM
export EDITOR=vim

# easy sudo editing
alias svim="sudoedit"

# start Sway if the config file is present
if [ "$(tty)" = "/dev/tty1" -a -f ".config/sway/config" ]; then
  exec sway
fi
