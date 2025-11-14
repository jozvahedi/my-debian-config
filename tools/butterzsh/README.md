# 🧈 ButterZsh
![Made for Debian](https://img.shields.io/badge/Made%20for-Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)

A smooth, modular Zsh configuration framework that makes your shell experience butter-smooth.

## ✨ Features

- **Modular Design**: Clean separation of concerns with individual files for aliases, functions, and configurations
- **Native Git Integration**: Uses Zsh's powerful vcs_info for git-aware prompts with status indicators
- **Smart Plugins**: Auto-loads syntax highlighting and fish-like autosuggestions
- **FZF Integration**: Fuzzy finding for files and processes
- **Advanced Completions**: Leverages Zsh's superior completion system
- **Extensive Aliases**: Productivity shortcuts including Zsh-specific global aliases
- **Archive Extraction**: Universal `extract` command for all archive types
- **System Functions**: Quick system info, colored man pages, and more
- **Extension Ready**: Works perfectly with [ButterNotes](https://codeberg.org/justaguylinux/butternotes) for note-taking and todo management

## 📦 Installation

### Prerequisites

Zsh version 5.0 or higher is recommended. The installer will check and offer to install zsh if needed.

### Recommended: Install via ButterScripts

The easiest way to install ButterZsh is through the [ButterScripts](https://codeberg.org/justaguylinux/butterscripts) optional installer:

```bash
# Clone and run butterscripts installer
git clone https://codeberg.org/justaguylinux/butterscripts.git
cd butterscripts/setup
./optional_tools.sh
# Select the ButterZsh option
```

### Direct Install

1. Clone the repository:
```bash
git clone https://codeberg.org/justaguylinux/butterzsh.git
cd butterzsh
```

2. Run the install script:
```bash
./install.sh
```

3. Start using Zsh:
```bash
zsh
# Or reload if already in zsh
source ~/.zshrc
```

> **Important**: ButterZsh will backup your existing `.zshrc` and replace it with a modular configuration. This is the intended behavior for the full ButterZsh experience.

## 🗂️ Structure

```
~/.config/zsh/
├── aliases.zsh         # Command shortcuts
├── prompt.zsh          # Custom prompt with git branch using vcs_info
├── keybinds.zsh        # Keyboard shortcuts
├── fzf.zsh            # FZF configuration
└── functions/
    ├── system.zsh     # System utilities
    └── utils.zsh      # General utilities
```

## 🎯 Core Functions

### Utility Functions
```bash
mkcd directory        # Create and enter directory
extract file.tar.gz   # Extract any archive type
backup file.txt       # Create timestamped backup
calc 2+2             # Quick calculations
sysinfo              # Display system information
```

### Zsh-Specific Features
```bash
# Global aliases (zsh-only feature)
ls -la G pattern     # Same as: ls -la | grep -i pattern
cat file L           # Same as: cat file | less
history T            # Same as: history | tail
```

## ⚙️ Configuration

### Customization

Add your own customizations by creating files in `~/.config/zsh/`:

1. Create a new module: `~/.config/zsh/custom.zsh`
2. It will be automatically loaded on next shell start

### Local Overrides

For machine-specific settings, create `~/.zshrc.local`:
```zsh
# ~/.zshrc.local
export CUSTOM_VAR="value"
alias myalias="command"

# Add custom configurations here
```

### Integration with Other Projects

ButterZsh works seamlessly with other projects in the ButterScripts ecosystem:
- **[ButterScripts](https://codeberg.org/justaguylinux/butterscripts)** - Comprehensive setup scripts for Debian systems
- **[ButterBash](https://codeberg.org/justaguylinux/butterbash)** - The Bash version of this framework
- **[ButterNotes](https://codeberg.org/justaguylinux/butternotes)** - Note-taking and todo management extension
- Integrates with terminal emulators like WezTerm
- Compatible with window managers (DWM, BSPWM, etc.)
- Works alongside other development tools and configurations

#### Want Note-Taking and Todo Management?

ButterZsh focuses on shell configuration. For productivity features like notes and todos, install **[ButterNotes](https://codeberg.org/justaguylinux/butternotes)**:

```bash
git clone https://codeberg.org/justaguylinux/butternotes.git
cd butternotes && ./install.sh
```

ButterNotes works perfectly alongside ButterZsh and adds:
- Intelligent note-taking with clipboard integration
- Todo management with markdown checkboxes
- Project organization with FZF
- Mobile sync compatibility
- Interactive terminal UI

## 🚀 Key Bindings

- **Ctrl+L**: Clear screen
- **↑/↓**: Search command history (matching current prefix)
- **Ctrl+R**: Reverse history search (with FZF if available)
- **Home/End**: Jump to beginning/end of line
- **Ctrl+←/→**: Jump by word
- **Ctrl+Backspace**: Delete previous word

## 📋 Requirements

- Zsh 5.0+
- Optional but recommended (auto-installed by installer):
  - `fzf` - Fuzzy finder
  - `ripgrep` - Fast grep alternative
  - `eza` or `exa` - Modern ls replacement
  - `zsh-syntax-highlighting` - Real-time syntax highlighting
  - `zsh-autosuggestions` - Fish-like command suggestions
  - `bat` - Cat with syntax highlighting
  - `fd` - Fast find alternative
  - `xclip` - Clipboard integration (X11)
  - `wl-clipboard` - Clipboard integration (Wayland)

The installer will offer to install these automatically.

## 🎨 Zsh Advantages

ButterZsh leverages Zsh's advanced features:
- **Superior Completions**: Smarter tab completion with menu selection
- **Glob Patterns**: Extended globbing with `**` for recursive matching
- **Global Aliases**: Pipe-style shortcuts that work anywhere in the command
- **vcs_info**: Native git integration with staged/unstaged indicators
- **Live Syntax Highlighting**: Commands turn green/red as you type (shows validity in real-time)
- **Smart Autosuggestions**: Gray text completion from history (accept with → or Ctrl+Space)
- **Spelling Correction**: Auto-correct for commands and paths
- **Shared History**: History shared across all terminal sessions

## 🤝 Contributing

Contributions are welcome! Please visit our [Codeberg repository](https://codeberg.org/justaguylinux/butterzsh) to:

- Report issues: https://codeberg.org/justaguylinux/butterzsh/issues
- Submit pull requests
- Join discussions

For major changes, please open an issue first to discuss your ideas.

## 📝 License

MIT

## 🙏 Acknowledgments

- Inspired by the popular [ButterBash](https://codeberg.org/justaguylinux/butterbash) framework
- Built with love for the Zsh community
- Thanks to all contributors and the open-source community

---

## ☕ Support

If ButterZsh has been helpful, consider buying me a coffee:

<a href="https://www.buymeacoffee.com/justaguylinux" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy me a coffee" /></a>

---

Made with 🧈 by [JustAGuyLinux](https://www.youtube.com/@justaguylinux)
