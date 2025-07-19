# Setting Up Project-Specific Git Identity

## Why This Matters

When collaborating, each person needs their commits to show their correct identity. Git allows per-directory configuration, so your work identity can be different from your personal projects.

## For Claude: Project Identity Setup

### 1. Check Current Git Config

```bash
# See global config (applies everywhere by default)
git config --global user.name
git config --global user.email

# See local config (applies only in current directory)
git config --local user.name
git config --local user.email

# See which config is being used
git config user.name
git config user.email
```

### 2. Set Project-Specific Identity

```bash
# Navigate to the project directory first!
cd ~/Development/collaborative-projects/[project-name]

# Set identity for THIS project only
git config --local user.name "Your Name"
git config --local user.email "your.email@example.com"

# Verify it worked
git config --local --list | grep user
```

### 3. GitHub CLI Identity

GitHub CLI (gh) uses authentication tokens, not git config. But we can verify the right account:

```bash
# Check which GitHub account is authenticated
gh auth status

# If multiple accounts, switch between them
gh auth switch

# Or login with a different account
gh auth login
```

### 4. Create a Setup Script

Let's create a script that sets everything up correctly:

```bash
cat > setup-identity.sh << 'EOF'
#!/bin/bash

# Project Identity Setup Script
echo "Setting up project-specific identity..."

# Prompt for user information
read -p "Enter your full name for git commits: " git_name
read -p "Enter your email for git commits: " git_email

# Set local git config
git config --local user.name "$git_name"
git config --local user.email "$git_email"

# Create a .gitconfig.local file (optional, for reference)
cat > .gitconfig.local << EOL
# Project-specific Git configuration
# This file is for reference only - actual config is in .git/config
[user]
    name = $git_name
    email = $git_email
EOL

# Show current configuration
echo ""
echo "✅ Git identity configured for this project:"
echo "Name: $(git config --local user.name)"
echo "Email: $(git config --local user.email)"
echo ""
echo "✅ GitHub CLI authenticated as:"
gh auth status | grep "Logged in to" || echo "Not logged in to GitHub"

# Create identity check file
cat > .identity-check << EOL
Project Git Identity:
Name: $git_name
Email: $git_email
Configured: $(date)
EOL

echo ""
echo "Setup complete! Your identity is configured for this project only."
echo "Run 'git config --local --list' to see all local settings."
EOF

chmod +x setup-identity.sh
```

### 5. Directory Structure for Multiple Projects

```bash
~/Development/
├── collaborative-projects/
│   ├── project-1/
│   │   ├── .git/config       # Contains local user.name and user.email
│   │   ├── .gitconfig.local  # Reference file (not used by git)
│   │   └── setup-identity.sh
│   ├── project-2/
│   │   ├── .git/config       # Different user.name and user.email
│   │   └── setup-identity.sh
│   └── shared-templates/
│       └── setup-identity.sh
```

## Creating a Starter Project Template

### Create the Template Repository Structure

```bash
# Create template project
mkdir -p ~/Development/collaborative-project-template
cd ~/Development/collaborative-project-template

# Initialize git
git init

# Create essential files
cp ~/path/to/COLLABORATIVE-SETUP-GUIDE.md ./
cp ~/path/to/CLAUDE-TEMPLATE.md ./CLAUDE.md
cp ~/path/to/QUICK-REFERENCE.md ./
cp ~/path/to/PROJECT-IDENTITY-SETUP.md ./
cp ~/path/to/setup-identity.sh ./

# Create project structure
mkdir -p src docs tests .github/workflows

# Create README
cat > README.md << 'EOF'
# Collaborative Project Template

This is a starter template for collaborative development using Claude Code.

## Quick Start

1. Clone this repository
2. Run `./setup-identity.sh` to configure your git identity for this project
3. Read `COLLABORATIVE-SETUP-GUIDE.md` for full setup instructions
4. Customize `CLAUDE.md` with your project details

## Important Files

- `COLLABORATIVE-SETUP-GUIDE.md` - Complete setup instructions
- `CLAUDE.md` - Project context (customize this!)
- `QUICK-REFERENCE.md` - Handy command reference
- `setup-identity.sh` - Configure your git identity

## First Time Setup

```bash
# 1. Clone the template
git clone [repository-url] my-project-name
cd my-project-name

# 2. Set your identity
./setup-identity.sh

# 3. Install required tools (if needed)
brew install gh

# 4. Authenticate with GitHub
gh auth login

# 5. Start working with Claude!
```
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Local identity files (don't commit personal info)
.gitconfig.local
.identity-check

# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/

# Dependencies
node_modules/
venv/
__pycache__/

# Environment files
.env
.env.local

# Build outputs
dist/
build/
*.log
EOF

# Create a session template
cat > SESSION-TEMPLATE.md << 'EOF'
# Work Session - [DATE]

## Session Goals
- [ ] Goal 1
- [ ] Goal 2

## Work Completed
- 

## Issues Encountered
- 

## Next Steps
- 

## Files Modified
- 

## Notes for Next Session
- 
EOF

# Create GitHub issue templates
mkdir -p .github/ISSUE_TEMPLATE

cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description
A clear description of what the bug is.

## To Reproduce
Steps to reproduce:
1. Go to '...'
2. Click on '....'
3. See error

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Additional Context
Add any other context about the problem here.
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

## Feature Description
A clear description of the feature.

## Why This Is Needed
Explain the problem this solves.

## Proposed Solution
How you think this could work.

## Alternatives Considered
Other solutions you've thought about.
EOF

# Initial commit
git add .
git commit -m "Initial commit: Collaborative project template"
```

## Checking Identity Before Commits

### Add a Pre-commit Hook

```bash
# Create a git hook to verify identity
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

# Check if user identity is configured locally
name=$(git config --local user.name)
email=$(git config --local user.email)

if [ -z "$name" ] || [ -z "$email" ]; then
    echo "❌ Error: Git identity not configured for this project!"
    echo "Please run: ./setup-identity.sh"
    exit 1
fi

echo "✅ Committing as: $name <$email>"
EOF

chmod +x .git/hooks/pre-commit
```

## For Your Collaborator: Complete Setup Flow

1. **They clone the template:**
   ```bash
   git clone [your-template-repo] our-project
   cd our-project
   ```

2. **They run identity setup:**
   ```bash
   ./setup-identity.sh
   # Enter their name
   # Enter their email
   ```

3. **They verify everything:**
   ```bash
   # Check git identity
   git config --local user.name  # Should show their name
   
   # Check GitHub auth
   gh auth status  # Should show their GitHub account
   
   # Make a test commit
   touch test.txt
   git add test.txt
   git commit -m "Test commit from [their-name]"
   git log -1  # Should show their name and email
   ```

## Important Notes

- **Local config overrides global**: Settings in the project directory take precedence
- **Don't commit .gitconfig.local**: It contains personal information
- **Each clone needs setup**: Every person must run setup-identity.sh after cloning
- **GitHub auth is separate**: `gh` uses tokens, not git config

## Troubleshooting

### Wrong identity showing in commits
```bash
# Check all config levels
git config --list --show-origin | grep user

# Force local config
git config --local user.name "Correct Name"
git config --local user.email "correct@email.com"
```

### GitHub CLI using wrong account
```bash
# Logout and login again
gh auth logout
gh auth login

# Or switch accounts
gh auth switch
```