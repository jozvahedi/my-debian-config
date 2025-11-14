#!/usr/bin/env bash
# ButterZsh Installation Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
BUTTERZSH_DIR="$HOME/.config/zsh"
BACKUP_DIR="$HOME/.config/zsh.backup.$(date +%Y%m%d_%H%M%S)"

# Print colored message
print_msg() {
    echo -e "${2}${1}${NC}"
}

# Print header
print_header() {
    echo
    print_msg "🧈 ButterZsh Installer" "$YELLOW"
    print_msg "=====================" "$YELLOW"
    echo
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if zsh is installed
check_zsh() {
    if ! command_exists zsh; then
        print_msg "⚠ Zsh is not installed!" "$YELLOW"
        echo
        read -p "$(echo -e ${YELLOW}Would you like to install zsh now? \(y/N\): ${NC})" -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_msg "📦 Installing zsh..." "$BLUE"

            if command_exists apt; then
                sudo apt update && sudo apt install -y zsh
            elif command_exists dnf; then
                sudo dnf install -y zsh
            elif command_exists pacman; then
                sudo pacman -S --noconfirm zsh
            elif command_exists brew; then
                brew install zsh
            else
                print_msg "   ❌ Could not detect package manager" "$RED"
                print_msg "   Please install zsh manually and re-run this installer" "$YELLOW"
                exit 1
            fi

            print_msg "   ✓ Zsh installed successfully" "$GREEN"
        else
            print_msg "Installation cancelled - zsh is required" "$RED"
            exit 1
        fi
    fi
}

# Backup existing configuration
backup_existing() {
    if [ -d "$BUTTERZSH_DIR" ] || [ -f "$HOME/.zshrc" ]; then
        print_msg "📦 Backing up existing configuration..." "$BLUE"

        # Backup .zshrc if it exists
        if [ -f "$HOME/.zshrc" ]; then
            cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
            print_msg "   ✓ Backed up .zshrc" "$GREEN"
        fi

        # Backup existing zsh config directory
        if [ -d "$BUTTERZSH_DIR" ]; then
            mv "$BUTTERZSH_DIR" "$BACKUP_DIR"
            print_msg "   ✓ Backed up existing config to $BACKUP_DIR" "$GREEN"
        fi
    fi
}

# Install ButterZsh
install_butterzsh() {
    print_msg "🚀 Installing ButterZsh..." "$BLUE"

    # Check if required files exist
    if [ ! -d "zsh" ] || [ ! -f "zshrc.example" ]; then
        print_msg "   ❌ Error: ButterZsh files not found!" "$RED"
        print_msg "   Please run the installer from the cloned butterzsh directory" "$YELLOW"
        exit 1
    fi

    # Create config directory
    mkdir -p "$BUTTERZSH_DIR/functions"

    # Copy configuration files
    cp -r zsh/* "$BUTTERZSH_DIR/"
    print_msg "   ✓ Copied configuration files" "$GREEN"

    # Install main zshrc
    cp zshrc.example "$HOME/.zshrc"
    print_msg "   ✓ Installed .zshrc" "$GREEN"
}

# Install optional dependencies
install_dependencies() {
    echo
    # Use /dev/tty to read from terminal even when piped
    if [[ -t 0 ]]; then
        # Normal interactive mode
        read -p "$(echo -e ${YELLOW}Would you like to install recommended tools and plugins? \(y/N\): ${NC})" -n 1 -r
    elif [[ -e /dev/tty ]]; then
        # Piped mode but terminal available
        read -p "$(echo -e ${YELLOW}Would you like to install recommended tools and plugins? \(y/N\): ${NC})" -n 1 -r </dev/tty
    else
        # No terminal available at all (like in CI/CD)
        print_msg "   ℹ Skipping optional tools (no terminal available)" "$YELLOW"
        return
    fi
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_msg "📦 Installing recommended tools and plugins..." "$BLUE"

        # Detect package manager
        if command_exists apt; then
            PKG_MGR="apt"
            INSTALL_CMD="sudo apt install -y"
        elif command_exists dnf; then
            PKG_MGR="dnf"
            INSTALL_CMD="sudo dnf install -y"
        elif command_exists pacman; then
            PKG_MGR="pacman"
            INSTALL_CMD="sudo pacman -S --noconfirm"
        elif command_exists brew; then
            PKG_MGR="brew"
            INSTALL_CMD="brew install"
        else
            print_msg "   ⚠ Could not detect package manager" "$YELLOW"
            return
        fi

        # Install fzf
        if ! command_exists fzf; then
            print_msg "   Installing fzf..." "$BLUE"
            $INSTALL_CMD fzf
        else
            print_msg "   ✓ fzf already installed" "$GREEN"
        fi

        # Install ripgrep
        if ! command_exists rg; then
            print_msg "   Installing ripgrep..." "$BLUE"
            $INSTALL_CMD ripgrep
        else
            print_msg "   ✓ ripgrep already installed" "$GREEN"
        fi

        # Try to install eza (might not be available in all repos)
        if ! command_exists eza && ! command_exists exa; then
            print_msg "   Installing eza/exa..." "$BLUE"
            $INSTALL_CMD eza 2>/dev/null || $INSTALL_CMD exa 2>/dev/null || print_msg "   ⚠ eza/exa not available" "$YELLOW"
        else
            print_msg "   ✓ eza/exa already installed" "$GREEN"
        fi

        # Install zsh plugins
        print_msg "   Installing zsh plugins..." "$BLUE"

        # Install zsh-syntax-highlighting
        if [ ! -d "/usr/share/zsh-syntax-highlighting" ]; then
            print_msg "   Installing zsh-syntax-highlighting..." "$BLUE"
            $INSTALL_CMD zsh-syntax-highlighting 2>/dev/null || print_msg "   ⚠ zsh-syntax-highlighting not available" "$YELLOW"
        else
            print_msg "   ✓ zsh-syntax-highlighting already installed" "$GREEN"
        fi

        # Install zsh-autosuggestions
        if [ ! -d "/usr/share/zsh-autosuggestions" ]; then
            print_msg "   Installing zsh-autosuggestions..." "$BLUE"
            $INSTALL_CMD zsh-autosuggestions 2>/dev/null || print_msg "   ⚠ zsh-autosuggestions not available" "$YELLOW"
        else
            print_msg "   ✓ zsh-autosuggestions already installed" "$GREEN"
        fi
    fi
}

# Set zsh as default shell
set_default_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo
        read -p "$(echo -e ${YELLOW}Would you like to set zsh as your default shell? \(y/N\): ${NC})" -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_msg "🔧 Setting zsh as default shell..." "$BLUE"
            chsh -s "$(which zsh)"
            print_msg "   ✓ Default shell set to zsh" "$GREEN"
            print_msg "   ℹ You'll need to log out and back in for this to take effect" "$YELLOW"
        fi
    fi
}

# Main installation
main() {
    print_header

    # Check if zsh is installed
    check_zsh

    # Check zsh version
    ZSH_VERSION_NUM=$(zsh --version | awk '{print $2}' | cut -d. -f1)
    if [ "${ZSH_VERSION_NUM}" -lt 5 ]; then
        print_msg "⚠ Warning: Zsh version 5+ recommended (you have $(zsh --version))" "$YELLOW"
    fi

    # Skip confirmation if called with --yes flag or from another installer
    if [[ "$1" != "--yes" ]] && [[ -z "$SKIP_CONFIRMATION" ]]; then
        # Confirm installation
        echo "This will install ButterZsh to $BUTTERZSH_DIR"
        echo "Your existing configuration will be backed up."
        echo
        read -p "$(echo -e ${YELLOW}Continue with installation? \(y/N\): ${NC})" -n 1 -r
        echo

        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_msg "Installation cancelled" "$RED"
            exit 1
        fi
    fi

    # Run installation steps
    backup_existing
    install_butterzsh
    install_dependencies
    set_default_shell

    # Success message
    echo
    print_msg "✨ ButterZsh installed successfully!" "$GREEN"
    echo
    print_msg "To get started:" "$BLUE"
    print_msg "  1. Start a new zsh session: zsh" "$NC"
    print_msg "  2. Or reload your config: source ~/.zshrc" "$NC"
    print_msg "  3. Check the README for full documentation" "$NC"
    echo
    print_msg "Enjoy your butter-smooth zsh experience! 🧈" "$YELLOW"
}

# Run main function
main "$@"
