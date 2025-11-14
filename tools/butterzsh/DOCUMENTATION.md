# ButterZsh Documentation

Complete guide to using and customizing ButterZsh.

## Table of Contents

1. [Installation](#installation)
2. [Configuration Files](#configuration-files)
3. [Aliases Reference](#aliases-reference)
4. [Functions Reference](#functions-reference)
5. [Customization](#customization)
6. [Zsh-Specific Features](#zsh-specific-features)
7. [Troubleshooting](#troubleshooting)

## Installation

### System Requirements

- **Zsh**: Version 5.0 or higher
- **OS**: Debian/Ubuntu (optimized), but works on most Linux distributions and macOS
- **Optional Tools**: fzf, ripgrep, eza/exa, bat, fd

### Installation Steps

```bash
git clone https://codeberg.org/justaguylinux/butterzsh.git
cd butterzsh
./install.sh
```

The installer will:
1. Check if zsh is installed (offer to install if not)
2. Backup your existing `.zshrc` and `~/.config/zsh/`
3. Copy configuration files to `~/.config/zsh/`
4. Offer to install recommended tools
5. Optionally set zsh as your default shell

## Configuration Files

### Main Configuration: `~/.zshrc`

The main configuration file that:
- Sets Zsh options and shell behavior
- Configures history settings
- Loads all modular configuration files
- Initializes the completion system
- Sets environment variables

### Modular Files in `~/.config/zsh/`

#### `aliases.zsh`
All command aliases and shortcuts. Includes:
- Navigation shortcuts (`..`, `...`, etc.)
- Enhanced `ls` commands (with eza/exa support)
- Git aliases
- System information aliases
- Package management shortcuts
- Zsh-specific global aliases

#### `prompt.zsh`
Prompt configuration using Zsh's native `vcs_info`:
- Git branch display
- Staged/unstaged change indicators
- SSH connection indicator
- Exit status indicator (right prompt)
- Color-coded elements

#### `fzf.zsh`
FZF integration:
- `vf` - Fuzzy find and edit files
- `fkill` - Fuzzy find and kill processes
- Key bindings (Ctrl+T, Ctrl+R, Alt+C)
- Custom FZF options
- fd integration for faster searching

#### `keybinds.zsh`
Keyboard shortcuts:
- Emacs-style bindings by default
- History search with arrow keys
- Word navigation with Ctrl+Arrow
- Standard terminal shortcuts

#### `functions/system.zsh`
System-related functions:
- `command_exists` - Check if a command is available
- `sysinfo` - Display comprehensive system information
- `man` - Colored man pages
- `install_tools` - Install fzf and ripgrep

#### `functions/utils.zsh`
Utility functions:
- `mkcd` - Create directory and cd into it
- `backup` - Create timestamped backup of files
- `extract` - Universal archive extraction
- `hgrep` - Search command history
- `dirsize` - Get directory size
- `calc` - Quick calculations
- `path` - Display PATH in readable format

## Aliases Reference

### Navigation
```zsh
..      # cd ..
...     # cd ../..
....    # cd ../../..
~       # cd ~
-       # cd to previous directory
```

### File Operations
```zsh
l       # Long listing with eza/exa
ls      # List all with icons
ll      # Long list all with icons
la      # List all
lt      # Tree view (2 levels)
lh      # List by modification time
```

### Git Shortcuts
```zsh
g       # git
gs      # git status
ga      # git add
gaa     # git add -A
gc      # git commit
gcm     # git commit -m
gp      # git push
gpl     # git pull
gco     # git checkout
gb      # git branch
gd      # git diff
gl      # git log --oneline --graph
```

### System Info
```zsh
df      # Disk usage (human readable)
free    # Memory usage (human readable)
top     # btop/htop/top
mem     # Show top 5 memory-consuming processes
cpu     # Show top 5 CPU-consuming processes
```

### Global Aliases (Zsh-specific)
```zsh
G       # | grep -i
L       # | less
H       # | head
T       # | tail
N       # 2>/dev/null
J       # | jq

# Examples:
ps aux G firefox    # Same as: ps aux | grep -i firefox
cat file L          # Same as: cat file | less
history T           # Same as: history | tail
```

## Functions Reference

### File Management

#### `mkcd <directory>`
Create a directory and immediately cd into it.
```zsh
mkcd ~/projects/new-app
```

#### `backup <file>`
Create a timestamped backup of a file.
```zsh
backup important.conf
# Creates: important.conf.backup.20231225_143022
```

#### `extract <archive>`
Extract any archive format automatically.
```zsh
extract archive.tar.gz
extract file.zip
extract package.7z
```

Supported formats: tar.gz, tar.bz2, tar.xz, zip, rar, 7z, and more.

### System Functions

#### `sysinfo`
Display comprehensive system information.
```zsh
sysinfo
# Shows: hostname, kernel, uptime, memory, load, disk usage
```

#### `install_tools`
Install recommended tools (fzf and ripgrep).
```zsh
install_tools
```

### Utility Functions

#### `calc <expression>`
Quick calculator.
```zsh
calc 2+2
calc 10/3
calc "sqrt(16)"
```

#### `path`
Display PATH variable in readable format.
```zsh
path
# Shows numbered list of directories in PATH
```

#### `dirsize [directory]`
Get the size of a directory.
```zsh
dirsize ~/Downloads
dirsize  # Current directory
```

#### `hgrep <pattern>`
Search command history.
```zsh
hgrep git
hgrep install
```

### FZF Functions

#### `vf`
Fuzzy find a file and open in editor.
```zsh
vf
# Opens interactive file finder
```

#### `fkill [signal]`
Fuzzy find and kill a process.
```zsh
fkill      # Kill with SIGKILL (9)
fkill 15   # Kill with SIGTERM (15)
```

## Customization

### Adding Custom Aliases

Create `~/.config/zsh/custom.zsh`:
```zsh
# Custom aliases
alias myproject='cd ~/projects/important-project'
alias serve='python -m http.server 8000'
```

### Adding Custom Functions

Add to `~/.config/zsh/functions/custom.zsh`:
```zsh
# Custom function
weather() {
    curl "wttr.in/${1:-orlando}?u"
}
```

### Machine-Specific Settings

Use `~/.zshrc.local` for settings that shouldn't be in version control:
```zsh
# ~/.zshrc.local
export WORK_DIR="/path/to/work"
export API_KEY="secret-key"
alias vpn='sudo openvpn ~/work/vpn.conf'
```

### Changing the Prompt

Edit `~/.config/zsh/prompt.zsh` to customize your prompt. The default uses `vcs_info` for git integration.

Example minimal prompt:
```zsh
PROMPT='%F{blue}%~%f $ '
```

Example two-line prompt with time:
```zsh
PROMPT='%F{cyan}[%*]%f %F{green}%n@%m%f %F{blue}%~%f
%# '
```

### Changing Key Bindings

Edit `~/.config/zsh/keybinds.zsh`.

Switch to vi mode:
```zsh
# Comment out or remove
# bindkey -e

# Add
bindkey -v
```

## Zsh-Specific Features

### Advanced Completions

Zsh has the most powerful completion system:
- **Case-insensitive**: Completions work regardless of case
- **Substring matching**: Partial matches anywhere in the name
- **Menu selection**: Navigate completions with arrow keys
- **Grouped results**: Completions organized by type

### Glob Patterns

Extended globbing is enabled:
```zsh
ls **/*.txt          # Recursive search for .txt files
ls *.{jpg,png}       # Files matching multiple extensions
ls ^*.txt            # All files except .txt
ls **/test_*.py      # Recursive search with pattern
```

### History Features

- **Shared history**: All terminal sessions share history in real-time
- **Deduplication**: Duplicate commands automatically removed
- **Smart search**: Arrow keys search with current prefix
- **Timestamps**: History entries include timestamps

### Directory Stack

Automatic directory stack with `AUTO_PUSHD`:
```zsh
cd ~/projects
cd ~/Downloads
cd ~/Documents
cd -1    # Go back to ~/Downloads
cd -2    # Go back to ~/projects
dirs -v  # View directory stack
```

## Troubleshooting

### Prompt Not Showing Git Branch

Make sure you're in a git repository and vcs_info is loaded:
```zsh
# Check if vcs_info is available
autoload -Uz vcs_info
vcs_info
echo $vcs_info_msg_0_
```

### Completions Not Working

Rebuild completion cache:
```zsh
rm -f ~/.zcompdump
compinit
```

### Slow Startup

Check which files are taking time:
```zsh
zsh -xv 2>&1 | ts -i '%.s'
```

Or profile with:
```zsh
zmodload zsh/zprof
# ... (start new shell)
zprof
```

### FZF Key Bindings Not Working

Make sure fzf is installed and the key-bindings file is sourced:
```zsh
command -v fzf
# Should output the path to fzf

# Check if bindings exist
ls /usr/share/fzf/key-bindings.zsh
ls /usr/share/doc/fzf/examples/key-bindings.zsh
```

### Reset to Default Configuration

If you need to start over:
```bash
# Backup current config
mv ~/.config/zsh ~/.config/zsh.old
mv ~/.zshrc ~/.zshrc.old

# Reinstall
cd butterzsh
./install.sh
```

## Additional Resources

- [Zsh Documentation](http://zsh.sourceforge.net/Doc/)
- [Zsh Wiki](https://zshwiki.org/)
- [FZF GitHub](https://github.com/junegunn/fzf)
- [ButterBash](https://codeberg.org/justaguylinux/butterbash) - Bash version
- [ButterNotes](https://codeberg.org/justaguylinux/butternotes) - Note-taking companion

## Getting Help

- Check the [README](README.md) for quick start
- Open an issue: https://codeberg.org/justaguylinux/butterzsh/issues
- Watch tutorials: [JustAGuyLinux YouTube](https://www.youtube.com/@justaguylinux)
