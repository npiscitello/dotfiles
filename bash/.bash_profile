# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# start Sway if the config file is present
if [ "$(tty)" = "/dev/tty1" -a -f ".config/sway/config" ]; then
  exec ~/.config/sway/start-sway.sh
fi
