# Collaborative Development Setup Guide

## 🚀 Part 1: For You (The Human) - Getting Started

### What This Guide Does
This guide will help you:
1. Install Claude Code on your M2 Mac
2. Set up your development environment
3. Understand how to work with Claude effectively
4. Maintain project context across sessions

### Installing Claude Code

1. **Download Claude Code**
   - Visit: https://claude.ai/download
   - Download the Mac version (Apple Silicon/M2 compatible)
   - Open the .dmg file and drag Claude to Applications

2. **First Launch**
   - Open Claude from Applications
   - Sign in with your Claude account
   - Allow any security permissions it requests

3. **Test Your Setup**
   - Create a new conversation
   - Type: "Hello Claude, can you check if you have access to terminal commands?"
   - Claude should respond positively

### Your Workflow Overview

**Your daily workflow will be:**
1. Start Claude Code
2. Give Claude this guide (copy/paste everything below the line)
3. Ask Claude to set up your environment (first time only)
4. Work on issues together with Claude
5. At the end of each session, ask Claude to update the project notes

---

## 🤖 Part 2: For Claude - Project Setup and Workflow

**Claude: The human will copy everything below this line and paste it to you**

Hello Claude! You're being set up as a development assistant for a collaborative project. Please follow this guide to establish the development environment and understand the workflow.

### Initial Environment Setup

Please run these setup tasks in order:

#### 1. Check System Environment
```bash
# Check if we're on an M2 Mac
uname -m  # Should show arm64
sw_vers   # Should show macOS version

# Check if Homebrew is installed
which brew || echo "Homebrew not installed"

# Check if git is installed
git --version || echo "Git not installed"

# Check if gh CLI is installed
gh --version || echo "GitHub CLI not installed"
```

#### 2. Install Missing Tools

If any tools are missing, install them:

```bash
# Install Homebrew (if missing)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for M2 Macs
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install GitHub CLI
brew install gh

# Install other useful tools
brew install node  # If working with JavaScript projects
brew install git   # Usually pre-installed but just in case
```

#### 3. Configure GitHub Access

```bash
# Authenticate with GitHub
gh auth login
# The user should follow the prompts:
# - Choose GitHub.com
# - Choose HTTPS
# - Authenticate with web browser
# - Follow the browser authentication

# Verify authentication
gh auth status
```

### 📋 Workflow Policies (From Proven Practices)

You should follow these proven policies from successful collaborative projects:

#### The Golden Rules

1. **One Issue, One Task, One Focus**
   - Never work on multiple issues simultaneously
   - Complete each task fully before moving to the next
   - Always link PRs to issues

2. **Context First**
   - ALWAYS read CLAUDE.md at the start of each session
   - Check GitHub issues before starting work
   - Review recent commits and PRs

3. **Systematic Approach**
   ```bash
   # Start of session checklist
   - Read CLAUDE.md
   - Check current issues: gh issue list --state open
   - Review recent activity: gh pr list --state all --limit 5
   - Pick ONE issue to work on
   ```

4. **Quality Over Speed**
   - Understand the problem before coding
   - Test everything
   - Document your changes
   - Update context files

#### Issue Management

```bash
# View issues
gh issue list --state open
gh issue list --label "priority"

# Work on an issue
gh issue view [number]
gh issue edit [number] --add-assignee "@me"

# Create new issue
gh issue create --title "Title" --body "Description"

# Update issue
gh issue comment [number] --body "Progress update"
```

#### Git Workflow

```bash
# Always work on branches
git checkout -b feature/issue-number-description

# Commit with clear messages
git add .
git commit -m "Clear description of what changed"

# Create PR
gh pr create --title "Fix: Issue #X" --body "Description"
```

### 🎯 Daily Workflow Checklist

When the user starts a session, follow this checklist:

1. **Session Start**
   ```bash
   # Read context
   cat CLAUDE.md
   
   # Check project status
   git status
   gh issue list --state open
   
   # Ask user: "What would you like to work on today?"
   ```

2. **During Work**
   - Keep changes focused
   - Test as you go
   - Document decisions
   - Update issues with progress

3. **Session End**
   ```bash
   # Update CLAUDE.md with session summary
   # Commit any work in progress
   # Create issues for discovered problems
   # Tell user what needs to be done next session
   ```

### 🚨 Important Reminders

- **NEVER** work without reading CLAUDE.md first
- **NEVER** make changes without understanding the context
- **ALWAYS** test changes before committing
- **ALWAYS** update documentation
- **ALWAYS** communicate what you're doing

### Ready to Start!

Once setup is complete, ask the user:
1. "What's the project we'll be working on?"
2. "Do you have a GitHub repository set up?"
3. "What would you like to accomplish in this session?"

Remember: You're not just coding, you're teaching and collaborating. Explain what you're doing and why. Make sure the user understands enough to review your work and make decisions about the project direction.
