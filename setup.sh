# todo: if component is bad and action is not 'help', no output

# return values:
# 1 - not enough arguments

# get the location of the script from the call
REPO_DIR=`realpath .`
for (( i=2; i<=$#; i+=1 )); do
  COMPONENTS="$COMPONENTS ${!i}"
done

# functions for logging warnings and errors
info () { echo -e "\x1B[32m[INF] " $@ "\x1B[0m"; }
warn () { echo -e "\x1B[33m[WRN] " $@ "\x1B[0m"; }
error () { echo -e "\x1B[31m[ERR] " $@ "\x1B[0m"; }

# for debugging
#info "enclosing directory: " $REPO_DIR

# various useful commands
MKDIR_CMD="mkdir -vp"
SYMLN_CMD="ln -vs"
HRDLN_CMD="ln -v"
RM_CMD="rm -vr"
EXEC_CMD="chmod +x"

symlink () { 
  if [[ -e $2 ]]; then
    warn $2 "already exists, skipping"
  else
    $SYMLN_CMD $1 $2
  fi 
}

symlink_sudo () { 
  if sudo bash -c "[[ -e $2 ]]"; then
    warn $2 "already exists, skipping"
  else
    sudo $SYMLN_CMD $1 $2
  fi 
}

hardlink_sudo () {
  if sudo bash -c "[[ -e $2 ]]"; then
    warn $2 "already exists, skipping"
  else
    sudo $HRDLN_CMD $1 $2
  fi
}

remove () {
  if [[ -e $1 ]]; then
    $RM_CMD $1
  else
    warn $1 "doesn't exist, skipping"
  fi
}

remove_sudo () {
  if sudo bash -c "[[ -e $1 ]]"; then
    sudo $RM_CMD $1
  else
    warn $1 "doesn't exist, skipping"
  fi 
}

# common actions
INSTALL=install
REMOVE=remove
UPDATE=update
HELP=help

# common components
ALL=all
VIM=vim
SWAY=sway
PORTAGE=portage
UDEV=udev
BASH=bash
REPO=repo

# print help text
# args: helptext
helptext () {
  info "npiscitello's configuration installer"
  info "usage: ./setup.sh [ action ] [ component ] [ component ] ..."
  info ""
  info "actions (exactly one must be present):"
  info "\t$HELP    - show this helptext and exit without doing anything"
  info "\t$INSTALL - symlink relevant files to the filesystem"
  info "\t$REMOVE  - delete configs of the specified components"
  info "\t$UPDATE  - run any applicable updates on the specified components"
  info "\t\tWARNING: this tool will not differentiate between its"
  info "\t\town configs and custom user configs. Use with caution!"
  info ""
  info "components (at least one must be present):"
  info "\t$ALL  - all configs (as if you passed every argument below)"
  info "\t$VIM  - the ~/.vim directory and the ~/.vimrc file"
  info "\t$SWAY - the Sway setup in the ~/.config directory and other graphical things"
  info "\t$PORTAGE - Portage config files in the /etc/portage directory"
  info "\t$UDEV - udev rules in /etc/udev/rules.d (calls sudo)"
  info "\t$BASH - the ~/.bash_profile file"
  info "\t$REPO - the 'dotfiles' repo itself"
  info ""
  info "Remember, not all actions are applicable to all components!"
  info ""
  info "Since everything is symlinked back to this folder, changing any config"
  info "file should be mirrored in this folder. Commit to save those changes."
  info "If this folder is moved or deleted, all of your configs will break!"
}

# print an action error
# args: bad_action action component
bad_action () {
  error "The '$1' action is not applicable to $2!"
  helptext
}

# check that enough arguments were passed
if [[ $# -lt 2 ]]; then
  error "Not enough arguments!"
  helptext
  exit 1
fi

# collect the action from the command line
ACTION=$1

# Vim
if [[ $COMPONENTS =~ $VIM ]] || [[ $COMPONENTS =~ $ALL ]]; then
  case $ACTION in
    $INSTALL)
      info "Installing Vim config..."
      symlink $REPO_DIR/vim ~/.vim
      symlink $REPO_DIR/vim/.vimrc ~/.vimrc
      info "Don't forget to run \`vim +PluginInstall\` and to compile YCM!"
      info "On Arch, that involves a standalone clang install"
      ;;

    $REMOVE)
      info "Removing Vim config..."
      remove ~/.vim
      remove ~/.vimrc
      ;;

    $UPDATE)
      info "Updating Vim plugins via Vundle..."
      vim +PluginUpdate
      ;;

    $HELP)
      info "Valid actions on the $VIM component: $INSTALL $REMOVE $UPDATE $HELP"
      info ""
      ;;
      
    *)
      bad_action $ACTION $VIM
  esac
fi

# Sway
if [[ $COMPONENTS =~ $SWAY ]] || [[ $COMPONENTS =~ $ALL ]]; then
  case $ACTION in
    $INSTALL)
      info "Installing Sway (and related applications) config..."
      $MKDIR_CMD ~/.config
      symlink $REPO_DIR/sway ~/.config/sway
      $EXEC_CMD $REPO_DIR/sway/start-sway.sh
      symlink $REPO_DIR/swaylock ~/.config/swaylock
      symlink $REPO_DIR/waybar ~/.config/waybar
      symlink $REPO_DIR/wofi ~/.config/wofi
      symlink $REPO_DIR/kitty ~/.config/kitty
      ;;

    $REMOVE)
      info "Removing Sway (and related applications) config..."
      remove ~/.config/sway
      remove ~/.config/swaylock
      remove ~/.config/waybar
      remove ~/.config/wofi
      remove ~/.config/kitty
      ;;

    $HELP)
      info "Valid actions on the $SWAY component: $INSTALL $REMOVE $HELP"
      info ""
      ;;

    *)
      bad_action $ACTION $SWAY
  esac
fi

# Portage
if [[ $COMPONENTS =~ $PORTAGE ]] || [[ $COMPONENTS =~ $ALL ]]; then
  case $ACTION in
    $INSTALL)
      # these should all be owned by root and have 644 permissions
      info "Installing Portage config..."
      symlink_sudo $REPO_DIR/portage/make.conf /etc/portage/make.conf
      symlink_sudo $REPO_DIR/portage/package.accept_keywords /etc/portage/package.accept_keywords
      symlink_sudo $REPO_DIR/portage/package.license /etc/portage/package.license
      symlink_sudo $REPO_DIR/portage/package.mask /etc/portage/package.mask
      symlink_sudo $REPO_DIR/portage/package.use /etc/portage/package.use
      ;;

    $REMOVE)
      warn "I'm quite sure you don't want to do that..."
      ;;

    $HELP)
      info "Valid actions on the $PORTAGE component: $INSTALL $REMOVE $HELP"
      info ""
      ;;

    *)
      bad_action $ACTION $SWAY
  esac
fi

# udev
if [[ $COMPONENTS =~ $UDEV ]] || [[ $COMPONENTS =~ $ALL ]]; then
  case $ACTION in
    $INSTALL)
      info "Installing udev rules (calls sudo)..."
      cd udev
      for rule in *; do
        hardlink_sudo $rule /etc/udev/rules.d/$rule
      done
      cd ..
      ;;

    $REMOVE)
      info "Removing udev rules (calls sudo)..."
      cd udev
      for rule in *; do
        remove_sudo /etc/udev/rules.d/$rule
      done
      cd ..
      ;;

    $HELP)
      info "Valid actions on the $UDEV component: $INSTALL $REMOVE $HELP"
      info ""
      ;;

    *)
      bad_action $ACTION $SWAY
  esac
fi

# bash
if [[ $COMPONENTS =~ $BASH ]] || [[ $COMPONENTS =~ $ALL ]]; then
  case $ACTION in
    $INSTALL)
      info "Installing bash config..."
      symlink $REPO_DIR/bash/.bash_profile ~/.bash_profile
      symlink $REPO_DIR/bash/.bashrc ~/.bashrc
      info "Don't forget to source .bash_profile and .bashrc to see any changes!"
      ;;

    $REMOVE)
      info "Removing bash config - this will leave you without a .bash_profile and .bashrc!"
      remove ~/.bash_profile
      remove ~/.bashrc
      ;;

    $HELP)
      info "Valid actions on the $BASH component: $INSTALL $REMOVE $HELP"
      info "If you run $INSTALL but nothing happens, check if .bash_profile"
      info "already exists. If it does, delete or rename it."
      info ""
      ;;

    *)
      bad_action $ACTION $BASH
  esac
fi

# repo
if [[ $COMPONENTS =~ $REPO ]] || [[ $COMPONENTS =~ $ALL ]]; then
  case $ACTION in
    $REMOVE)
      info "coming soon - an autoremove feature to erase all traces of this repo from your system!"
      ;;

    $UPDATE)
      info "Updating the dotfiles repo..."
      git fetch
      git merge
      git submodule update --remote
      ;;

    $HELP)
      info "Valid actions on the $REPO component: $REMOVE $UPDATE $HELP"
      info ""
      ;;

    *)
      bad_action $ACTION $REPO
  esac
fi

if [[ "$ACTION" = "$HELP" ]]; then
  helptext
fi
