#!/usr/bin/env zsh
# Git plugin with enhanced aliases and functions

# ============================================================================
# ADVANCED GIT ALIASES
# ============================================================================

# Branch management
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gbr='git branch -r'
alias gbm='git branch -m'

# Stash operations
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsts='git stash show'
alias gstd='git stash drop'

# Log variations
alias glg='git log --graph --oneline --decorate --all'
alias glo='git log --oneline --decorate'
alias glp='git log --pretty=format:"%h %s" --graph'
alias gll='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Diff operations
alias gdw='git diff --word-diff'
alias gds='git diff --staged'
alias gdh='git diff HEAD'

# Reset operations
alias grh='git reset HEAD'
alias grhh='git reset --hard HEAD'
alias groh='git reset --hard origin/$(git_current_branch)'

# Remote operations
alias gra='git remote add'
alias grv='git remote -v'
alias gru='git remote update'
alias grr='git remote remove'

# Merge and rebase
alias gm='git merge'
alias gma='git merge --abort'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'

# Cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# Tags
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl='git tag -l'

# Submodules
alias gsm='git submodule'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gsma='git submodule add'

# Show
alias gsh='git show'
alias gshs='git show --stat'

# Clean
alias gclean='git clean -fd'
alias gcleanf='git clean -ffd'

# ============================================================================
# GIT FUNCTIONS
# ============================================================================

# Get current branch name
git_current_branch() {
    git branch 2>/dev/null | sed -n '/^\*/s/^\* //p'
}

# Quick commit with message
gcam() {
    git add -A && git commit -m "$*"
}

# Quick commit and push
gcap() {
    git add -A && git commit -m "$*" && git push
}

# Create and checkout new branch
gcb() {
    if [ -z "$1" ]; then
        echo "Usage: gcb <branch-name>"
        return 1
    fi
    git checkout -b "$1"
}

# Checkout branch with fuzzy finding (requires fzf)
gcof() {
    if ! command -v fzf >/dev/null 2>&1; then
        echo "fzf is required for this function"
        return 1
    fi
    local branch
    branch=$(git branch --all | grep -v HEAD | sed 's/remotes\/origin\///' | sort -u | fzf) && git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Delete merged branches (except main/master/develop)
gcleanup() {
    git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -n 1 git branch -d
}

# Show git status in short format
gss() {
    git status -sb
}

# Undo last commit (keep changes)
gundo() {
    git reset --soft HEAD~1
}

# Amend last commit
gamend() {
    git commit --amend --no-edit
}

# Show contributors
gcontrib() {
    git shortlog -sn
}

# Show file history
ghistory() {
    if [ -z "$1" ]; then
        echo "Usage: ghistory <file>"
        return 1
    fi
    git log --follow -p -- "$1"
}

# Interactive rebase for last N commits
grbi() {
    local count="${1:-5}"
    git rebase -i HEAD~"$count"
}

# Show branches with last commit info
gbv() {
    git branch -v
}

# Quick push to current branch
gpush() {
    local branch=$(git_current_branch)
    if [ -z "$branch" ]; then
        echo "Not in a git repository"
        return 1
    fi
    git push origin "$branch"
}

# Quick pull from current branch
gpull() {
    local branch=$(git_current_branch)
    if [ -z "$branch" ]; then
        echo "Not in a git repository"
        return 1
    fi
    git pull origin "$branch"
}

# Force push with lease (safer)
gpf() {
    local branch=$(git_current_branch)
    if [ -z "$branch" ]; then
        echo "Not in a git repository"
        return 1
    fi
    echo "Force pushing to $branch with --force-with-lease"
    git push --force-with-lease origin "$branch"
}

# Show what changed in last commit
glast() {
    git log -1 HEAD --stat
}

# Git ignore - add pattern to .gitignore
gignore() {
    if [ -z "$1" ]; then
        echo "Usage: gignore <pattern>"
        return 1
    fi
    echo "$1" >> .gitignore
    echo "Added '$1' to .gitignore"
}

# Clone and cd into directory
gclonecd() {
    if [ -z "$1" ]; then
        echo "Usage: gclonecd <repo-url>"
        return 1
    fi
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Show commits not yet pushed
gunpushed() {
    local branch=$(git_current_branch)
    git log origin/"$branch"..HEAD
}

# Show commits not yet pulled
gunpulled() {
    local branch=$(git_current_branch)
    git fetch && git log HEAD..origin/"$branch"
}

# Create a new repository and initial commit
ginit() {
    git init
    git add .
    git commit -m "Initial commit"
    echo "Repository initialized with initial commit"
}

# Sync fork with upstream
gsync() {
    if [ -z "$1" ]; then
        echo "Usage: gsync <upstream-remote> [branch]"
        echo "Example: gsync upstream main"
        return 1
    fi
    local remote="$1"
    local branch="${2:-main}"

    git fetch "$remote"
    git checkout "$branch"
    git merge "$remote/$branch"
    git push origin "$branch"
}
