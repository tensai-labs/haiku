#!/usr/bin/env bash
set -e

echo Installing haiku...

BASE_DIR=${XDG_CONFIG_HOME:-$HOME}
HAIKU_DIR=${HAIKU_DIR-"$BASE_DIR/.haiku"}
HAIKU_BIN_DIR="$HAIKU_DIR/bin"
HAIKU_MAN_DIR="$HAIKU_DIR/share/man/man1"
BIN_PATH="$HAIKU_BIN_DIR/haiku"

# Allow specifying a custom tag via command line argument
TAG=${1:-"v0.0.3"}
BUILD_FROM_SOURCE=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --latest) BUILD_FROM_SOURCE=true ;;
        *) TAG="$1" ;;
    esac
    shift
done

# Create the .haiku bin directory if it doesn't exist
mkdir -p $HAIKU_BIN_DIR

if [ "$BUILD_FROM_SOURCE" = true ]; then
    echo "Building latest version from source..."
    
    # Check if required tools are installed
    if ! command -v cargo &> /dev/null; then
        echo "Error: cargo is required to build from source. Please install Rust from https://rustup.rs/"
        exit 1
    fi
    
    # Clone and build
    TMP_DIR=$(mktemp -d)
    git clone https://github.com/tensai-labs/haiku.git "$TMP_DIR"
    cd "$TMP_DIR"
    cargo build --release
    cp target/release/haiku "$BIN_PATH"
    rm -rf "$TMP_DIR"
else
    echo "Installing haiku version $TAG..."
    BIN_URL="https://github.com/tensai-labs/haiku/releases/download/v$TAG/haiku"
    if ! curl -# -L $BIN_URL -o $BIN_PATH; then
        echo "Error: Failed to download haiku binary"
        exit 1
    fi
    
    # Make the binary executable
    chmod +x $BIN_PATH
    
    # Verify the binary is executable
    if ! $BIN_PATH --version &> /dev/null; then
        echo "Error: Downloaded file is not a valid executable"
        rm -f $BIN_PATH
        exit 1
    fi
fi

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