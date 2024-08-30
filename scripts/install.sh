#!/usr/bin/env bash
set -e

echo Installing latest dojo...
dojoup --branch main

echo Installing haiku...

BASE_DIR=${XDG_CONFIG_HOME:-$HOME}
HAIKU_DIR=${HAIKU_DIR-"$BASE_DIR/.haiku"}
HAIKU_BIN_DIR="$HAIKU_DIR/bin"
HAIKU_MAN_DIR="$HAIKU_DIR/share/man/man1"

# Allow specifying a custom tag via command line argument
TAG=${1:-"v0.0.2"}  # Default to v0.0.2 if no argument is provided

# Update the BIN_URL to use the specified tag
BIN_URL="https://github.com/edisontim/haiku/releases/download/$TAG/haiku"

echo "Installing haiku version $TAG..."

BIN_PATH="$HAIKU_BIN_DIR/haiku"

# Create the .haiku bin directory if it doesn't exist
mkdir -p $HAIKU_BIN_DIR

# Download the binary file
curl -# -L $BIN_URL -o $BIN_PATH
chmod +x $BIN_PATH

# Store the correct profile file (i.e. .profile for bash or .zshenv for ZSH).
case $SHELL in
*/zsh)
    PROFILE=${ZDOTDIR-"$HOME"}/.zshenv
    PREF_SHELL=zsh
    ;;
*/bash)
    PROFILE=$HOME/.bashrc
    PREF_SHELL=bash
    ;;
*/fish)
    PROFILE=$HOME/.config/fish/config.fish
    PREF_SHELL=fish
    ;;
*/ash)
    PROFILE=$HOME/.profile
    PREF_SHELL=ash
    ;;
*)
    echo "haiku: could not detect shell, manually add ${HAIKU_BIN_DIR} to your PATH."
    exit 1
esac

# Only add haiku if it isn't already in PATH.
if [[ ":$PATH:" != *":${HAIKU_BIN_DIR}:"* ]]; then
    # Add the haiku directory to the path and ensure the old PATH variables remain.
    echo >> $PROFILE && echo "export PATH=\"\$PATH:$HAIKU_BIN_DIR\"" >> $PROFILE
fi

echo "
⠀⠀⠀⠀⠀⠀⠀⣰⣾⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  _   _    _    ___ _  ___   _ 
⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ | | | |  / \  |_ _| |/ / | | |
⠀⠀⠀⠀⠀⣠⣿⣿⣟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ | |_| | / _ \  | || ' /| | | |
⠀⠀⠀⠀⣴⣿⡿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ |  _  |/ ___ \ | || . \| |_| |
⠀⠀⣠⠾⠋⠁⠀⣿⣿⣿⣥⣶⣤⣤⣀⠀⣀⠀⢀⣀⣀⣀⣠⣤⣤⣤⣶⣦⣄⡀ |_| |_/_/   \_\___|_|\_\\_____/ 
⠀⠀⠀⢀⣠⣤⣶⣿⣿⣿⣿⠿⠿⠟⠋⢸⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⠷  _   _    _    ___ _  ___   _ 
⢴⣶⣿⣿⣿⡿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⣿⣿⣿⠉⠁⠀⠀⠀⢰⣿⣿⣿⠏⠀ | | | |  / \  |_ _| |/ / | | |
⠀⠉⠙⠋⠀⣰⣿⣿⣿⣿⡿⢿⣿⣷⡄⠀⢸⣿⣿⡇⠀⠀⠀⢀⣾⣿⣿⡿⠀⠀ | |_| | / _ \  | || ' /| | | |
⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡇⠀⠈⠉⠁⠀⢀⣿⣿⣷⣴⣶⣶⣾⣿⣿⣿⠁⠀⠀ |  _  |/ ___ \ | || . \| |_| |
⠀⠀⠀⣰⣿⠿⠃⢸⣿⣿⡇⠀⠀⠀⠀⠀⠈⠻⢿⣿⡿⠿⠟⠿⠛⠛⠁⠀⠀⠀ |_| |_/_/   \_\___|_|\_\\_____/ 
⠀⣀⠼⠛⠁⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  _   _    _    ___ _  ___   _ 
⠈⠁⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ | | | |  / \  |_ _| |/ / | | |
⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ | |_| | / _ \  | || ' /| | | |
⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ |  _  |/ ___ \ | || . \| |_| |
⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ |_| |_/_/   \_\___|_|\_\\_____/ 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"

echo "Detected your preferred shell is ${PREF_SHELL} and added haiku to PATH. Run 'source ${PROFILE}' or start a new terminal session to use haiku."
echo "Then, simply run 'haiku' to run the haiku CLI."