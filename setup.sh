# get the location of the script from the call
REPO_DIR=$(dirname $(readlink -f "$0"))

# the command used to link configs to the repo folder
SYMLINK_CMD="ln -vfs"
MKDIR_CMD="mkdir -vp"
ECHO_CMD="echo -e"

# set up vim
$ECHO_CMD "\x1B[32mSetting up Vim config...\x1B[0m"
$SYMLINK_CMD $REPO_DIR/vim ~/.vim
$SYMLINK_CMD $REPO_DIR/vim/.vimrc ~/.vimrc

# set up sway
$ECHO_CMD "\x1B[32mSetting up Sway config...\x1B[0m"
$MKDIR_CMD ~/.config
$SYMLINK_CMD $REPO_DIR/sway ~/.config/sway
