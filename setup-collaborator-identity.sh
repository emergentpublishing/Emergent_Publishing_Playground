#!/bin/bash

# Collaborator Identity Setup Script
# This sets up a collaborator's identity for this emergentpublishing project

echo "=============================================="
echo "Collaborator Setup for Emergent Publishing"
echo "=============================================="
echo ""
echo "This will configure your identity for contributing to this project."
echo "Your commits will be associated with YOUR name, not Emergent Publishing."
echo ""

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "❌ Error: This doesn't appear to be a git repository."
    echo "Please run this script from the project root directory."
    exit 1
fi

# Prompt for user information
read -p "Enter YOUR full name for git commits: " git_name
if [ -z "$git_name" ]; then
    echo "❌ Error: Name cannot be empty"
    exit 1
fi

read -p "Enter YOUR email for git commits: " git_email
if [ -z "$git_email" ]; then
    echo "❌ Error: Email cannot be empty"
    exit 1
fi

# Set local git config
git config --local user.name "$git_name"
git config --local user.email "$git_email"

# Show current configuration
echo ""
echo "✅ Your identity has been configured for this project:"
echo "   Name: $(git config --local user.name)"
echo "   Email: $(git config --local user.email)"
echo ""
echo "This configuration only affects THIS project directory."
echo "Your global git settings remain unchanged."
echo ""

# Check GitHub CLI status
echo "GitHub CLI Status:"
if command -v gh &> /dev/null; then
    gh auth status 2>/dev/null | grep "Logged in to" || echo "   ⚠️  Not logged in to GitHub"
    echo ""
    echo "   Make sure you're logged into YOUR GitHub account, not emergentpublishing."
    echo "   If needed, run: gh auth login"
else
    echo "   ⚠️  GitHub CLI (gh) is not installed"
    echo "   To install on Mac: brew install gh"
fi

echo ""
echo "=============================================="
echo "Setup complete! 🎉"
echo "=============================================="
echo ""
echo "Your commits will show as: $git_name <$git_email>"
echo "But the repository remains under: github.com/emergentpublishing"
echo ""
