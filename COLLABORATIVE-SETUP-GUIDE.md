# Collaborative Development Setup Guide

## 🚀 Part 1: For You (The Human) - Getting Started

### Quick Setup Overview
We'll get you coding with Claude in just 3 steps:
1. Install Visual Studio Code (your coding environment)
2. Install Claude Code (your AI assistant)
3. Let Claude help with everything else!

### Step 1: Install Visual Studio Code

1. **Download VS Code**
   - Visit: https://code.visualstudio.com/
   - Click the big download button (it will detect your M2 Mac)
   - Open the downloaded file
   - Drag Visual Studio Code to your Applications folder

2. **Open VS Code**
   - Launch VS Code from Applications
   - When it opens, you'll see a welcome screen
   - **Important**: Look for "Terminal" in the top menu bar

### Step 2: Install Node.js (Required for Claude)

1. **Download Node.js**
   - Visit: https://nodejs.org/
   - Click the "LTS" version (the big green button)
   - Run the installer (just click "Continue" through all steps)

2. **Verify Installation**
   - In VS Code: Click `Terminal` → `New Terminal`
   - Type: `node --version`
   - You should see something like `v20.11.0` (or v18.x.x or higher)

### Step 3: Install and Start Claude Code

1. **In VS Code's Terminal**, type:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```
   (Press Enter and wait for it to finish)

2. **Start Claude Code**
   - Still in VS Code's Terminal, type:
   ```bash
   claude
   ```
   - Sign in with your Claude account when prompted

3. **Test Claude**
   - Once Claude starts, type: "Hi Claude! Can you help me check if everything is set up correctly?"
   - Claude should respond and can now help you with any setup issues!

### That's It! 🎉

Claude is now running and can help you with:
- Installing any missing tools (like Git or GitHub CLI)
- Setting up your project
- Troubleshooting any issues
- Writing code together

**Next**: Copy everything below the line and paste it to Claude to complete your setup

### Your Daily Workflow

Once everything is set up, your daily routine will be:
1. Open VS Code
2. Open Terminal in VS Code (`Terminal` → `New Terminal`)
3. Navigate to your project folder
4. Type `claude` to start Claude Code
5. Work on your project with Claude's help!

---

## 🤖 Part 2: For Claude - Complete the Setup

**Claude: The human will copy everything below this line and paste it to you**

Hello Claude! The user has just installed VS Code and Claude Code. You're now running inside VS Code's terminal. Please help them complete their development environment setup.

### First: Verify What's Already Installed

Tell the user: "Great! You've got Claude Code running. Let me help you complete your setup. First, I'll check what tools you already have."

Run these checks:

```bash
# Quick system check
echo "Checking your system..."
echo "Mac Architecture: $(uname -m)"
echo "macOS Version: $(sw_vers -productVersion)"
echo "Node.js: $(node --version 2>/dev/null || echo 'Not found')"
echo "Git: $(git --version 2>/dev/null || echo 'Not found')"
echo "GitHub CLI: $(gh --version 2>/dev/null || echo 'Not found')"
echo "Homebrew: $(brew --version 2>/dev/null || echo 'Not found')"
```

### Install Any Missing Tools

Based on what's missing, help the user install what they need:

#### If Homebrew is missing:
```bash
# Explain: "Homebrew is a package manager that makes installing tools easy"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# For M2 Macs, add to PATH:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### If Git is missing:
```bash
# Explain: "Git helps track changes to your code"
brew install git
```

#### If GitHub CLI is missing:
```bash
# Explain: "GitHub CLI lets us manage issues and pull requests"
brew install gh
```

### Set Up GitHub Access

Once gh is installed:
```bash
# Explain: "Let's connect to your GitHub account"
gh auth login
```

Guide them through:
1. Choose GitHub.com
2. Choose HTTPS  
3. Authenticate with a web browser
4. Let them know when it's successful

**Important**: Make sure they authenticate with THEIR GitHub account, not emergentpublishing. They need their own account to contribute to the emergentpublishing repository.

### Help Them Get Started

Ask the user these questions to understand what they want to work on:

1. **"Do you have a GitHub repository we'll be working with?"**
   - If yes: Help them clone it using `gh repo clone [username/repo]`
   - If no: Ask if they want to create a new project

2. **"What kind of project are we building?"**
   - Web application, mobile app, data analysis, etc.
   - This helps you suggest appropriate tools and structure

3. **"What would you like to accomplish in this session?"**
   - Set up the project structure?
   - Start coding a specific feature?
   - Learn how to use Claude Code effectively?

### Working Directory Setup

Help them create a good workspace:

```bash
# Create a development folder
mkdir -p ~/Development
cd ~/Development

# If cloning an existing repo:
# gh repo clone [username/repository-name]

# If creating a new project:
# mkdir [project-name]
# cd [project-name]
# git init
```

**Remember**: Always ask the user what they want to do rather than assuming!

### If They Want to Start the Playground Project

If the user mentions they want to work on the "Emergent_Publishing_Playground" project:

```bash
# Help them clone the playground
cd ~/Development
gh repo clone emergentpublishing/Emergent_Publishing_Playground
cd Emergent_Publishing_Playground

# Set up their identity for this project
./setup-collaborator-identity.sh

# Read the project context
cat CLAUDE.md
```

Then explain: "This project is already set up for collaboration! I can see the context and we can start working together."

### If They Want to Create a New Project

Help them set up a proper project structure based on their needs:

1. **Ask what type of project** (web app, library, data analysis, etc.)
2. **Create appropriate files** (package.json for Node.js, requirements.txt for Python, etc.)
3. **Set up a CLAUDE.md file** to track context
4. **Initialize git** and connect to GitHub if they want

Always customize the setup based on their specific project needs!

### 🚨 Troubleshooting Push Permission Issues

If the collaborator gets "Permission denied" errors when trying to push:

1. **Check their GitHub authentication**:
   ```bash
   gh auth status
   ```
   Should show THEIR GitHub username, not emergentpublishing.

2. **Make sure they're added as a collaborator**:
   - Tell them: "You need to be added as a collaborator to this repository"
   - Project owner should go to: https://github.com/emergentpublishing/Emergent_Publishing_Playground/settings/access
   - Add their GitHub username as a collaborator

3. **If still having issues, use branches and PRs**:
   ```bash
   # Create a branch for their work
   git checkout -b feature/their-username-changes
   
   # Make changes and commit
   git add .
   git commit -m "Description of changes"
   
   # Push their branch (this usually works even without direct push access)
   git push -u origin feature/their-username-changes
   
   # Create PR
   gh pr create --title "Title" --body "Description"
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