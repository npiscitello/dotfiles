# return values:
# 1 - not enough arguments
# 2 - the action was passed incorrectly

# get the location of the script from the call
REPO_DIR=$(dirname $(readlink -f "$0"))
for (( i=2; i<=$#; i+=1 )); do
  ARGS="$ARGS ${!i}"
done

# functions for logging warnings and errors
info () { echo -e "\x1B[32m[INF] " $@ "\x1B[0m"; }
warn () { echo -e "\x1B[33m[WRN] " $@ "\x1B[0m"; }
error () { echo -e "\x1B[31m[ERR] " $@ "\x1B[0m"; }

# various useful commands
MKDIR_CMD="mkdir -vp"
LN_CMD="ln -vs"
RM_CMD="rm -vr"
symlink () { if [[ -e $2 ]]; then warn $2 "already exists, skipping"; else $LN_CMD $1 $2; fi }
symlink_sudo () { if sudo bash -c "[[ -e $2 ]]"; then warn $2 "already exists, skipping"; else sudo $LN_CMD $1 $2; fi }
remove () { if [[ -e $1 ]]; then $RM_CMD $1; else warn $1 "doesn't exist, skipping"; fi }
remove_sudo () { if sudo bash -c "[[ -e $1 ]]"; then sudo $RM_CMD $1; else warn $1 "doesn't exist, skipping"; fi }

# print help text
helptext () {
  info "npiscitello's configuration installer"
  info "usage: ./setup.sh [ action ] [ component ] [ component ] ..."
  info ""
  info "actions (exactly one must be present):"
  info "\tinstall - symlink relevant files to the filesystem"
  info "\tremove  - delete configs of the specified components"
  info "\t\tWARNING: this tool will not differentiate between configs installed"
  info "\t\tby itself and custom user configs. Use with caution!"
  info ""
  info "components (at least one must be present):"
  info "\tall  - all configs (as if you passed every argument below)"
  info "\tvim  - the ~/.vim directory and the ~/.vimrc file"
  info "\tsway - the Sway setup in the ~/.config directory"
  info "\tudev - udev rules in /etc/udev/rules.d (calls sudo)"
  exit $1
}

# check that enough arguments were passed
if [[ $# -lt 2 ]]; then
  error ""
  error "Not enough arguments!"
  error ""
  helptext 1
fi

# parse out action
if [[ "$1" == "install" ]]; then
  INSTALL=true
elif [[ "$1" == "remove" ]]; then
  INSTALL=false
else
  error ""
  error "Invalid action!"
  error ""
  helptext 2
fi

# Vim
if [[ $ARGS =~ vim ]] || [[ $ARGS =~ all ]]; then
  if $INSTALL; then
    info "Installing Vim config..."
    symlink $REPO_DIR/vim ~/.vim
    symlink $REPO_DIR/vim/.vimrc ~/.vimrc
    info "Don't forget to compile YCM!"
  else
    info "Removing Vim config..."
    remove ~/.vim
    remove ~/.vimrc
  fi
fi

# Sway
if [[ $ARGS =~ sway ]] || [[ $ARGS =~ all ]]; then
  if $INSTALL; then
    info "Installing Sway config..."
    $MKDIR_CMD ~/.config
    symlink $REPO_DIR/sway ~/.config/sway
  else
    info "Removing Sway config..."
    remove ~/.config/sway
  fi
fi

# udev
if [[ $ARGS =~ udev ]] || [[ $ARGS =~ all ]]; then
  if $INSTALL; then
    info "Installing udev rules (calls sudo)..."
    cd udev
    for rule in *; do
      symlink_sudo $rule /etc/udev/rules.d/$rule
    done
    cd ..
  else
    info "Removing udev rules (calls sudo)..."
    cd udev
    for rule in *; do
      remove_sudo /etc/udev/rules.d/$rule
    done
    cd ..
  fi
fi
