#<TODO> Allow user to cherry-pick configs they want to install
# (possible implementation: test all possible targets against each argument, only
#   run the target if the arg matches the name. Basically, a Bash makefile...)
# another possibility: actually make it a makefile!

# get the location of the script from the call
REPO_DIR=$(dirname $(readlink -f "$0"))

# functions for logging warnings and errors
info () { echo -e "\x1B[32m[INF] " $@ "\x1B[0m"; }
warn () { echo -e "\x1B[33m[WRN] " $@ "\x1B[0m"; }
error () { echo -e "\x1B[31m[ERR] " $@ "\x1B[0m"; }

# various useful commands
symlink () { if [ -e $2 ]; then warn $2 "already exists, skipping"; else ln -vs $1 $2; fi }
MKDIR_CMD="mkdir -vp"

# set up vim
info "Setting up Vim config..."
symlink $REPO_DIR/vim ~/.vim
symlink $REPO_DIR/vim/.vimrc ~/.vimrc

# set up sway
info "Setting up Sway config..."
$MKDIR_CMD ~/.config
symlink $REPO_DIR/sway ~/.config/sway
