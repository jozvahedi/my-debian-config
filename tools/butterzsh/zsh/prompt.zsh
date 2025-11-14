#!/usr/bin/env zsh
# Prompt configuration using vcs_info

# Enable vcs_info for git support
autoload -Uz vcs_info
precmd() { vcs_info }

# Configure vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b%u%c)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}(%b|%a%u%c)%f'

# Enable prompt substitution
setopt PROMPT_SUBST

# Color definitions (using zsh's color system)
RED='%F{red}'
GREEN='%F{green}'
YELLOW='%F{yellow}'
BLUE='%F{blue}'
MAGENTA='%F{magenta}'
CYAN='%F{cyan}'
WHITE='%F{white}'
GRAY='%F{240}'
RESET='%f'

# SSH indicator
if [[ -n "$SSH_CLIENT" ]]; then
    ssh_message="${RED}-ssh${RESET}"
else
    ssh_message=""
fi

# Enhanced prompt with git branch (multi-line)
PROMPT="${GRAY}%T ${GREEN}%n${ssh_message} ${WHITE}at ${YELLOW}%m ${WHITE}in ${BLUE}%~${CYAN}\${vcs_info_msg_0_}
${CYAN}$ ${RESET}"

# Right prompt with exit code (optional)
RPROMPT='%(?.%F{green}✓%f.%F{red}✗ %?%f)'
