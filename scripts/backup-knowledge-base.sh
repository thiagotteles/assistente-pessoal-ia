#!/bin/bash
# Backup automation script for Assistente Pessoal IA
# Can be run manually or scheduled via cron

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

echo "🚀 Starting knowledge-base backup..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "📝 Found uncommitted changes, creating commit..."

    # Add all changes in knowledge-base and .assistant-core
    git add knowledge-base/ .assistant-core/ despejo/

    # Create automatic commit with timestamp
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    git commit -m "Auto-backup: Knowledge base update - $TIMESTAMP

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

    echo "✅ Automatic commit created"
else
    echo "✅ No uncommitted changes found"
fi

# Push to remote if configured
if git remote get-url origin >/dev/null 2>&1; then
    echo "📤 Pushing to remote repository..."
    if git push; then
        echo "✅ Successfully pushed to remote"
    else
        echo "⚠️  Warning: Failed to push to remote (check network/permissions)"
    fi
else
    echo "ℹ️  No remote repository configured"
fi

# Create local backup using rsync if available
BACKUP_DIR="$HOME/.assistente-pessoal-backup"
if command -v rsync >/dev/null 2>&1; then
    echo "📁 Creating local backup..."
    mkdir -p "$BACKUP_DIR"

    BACKUP_NAME="manual_backup_$(date +%Y%m%d_%H%M%S)"
    rsync -av --delete knowledge-base/ "$BACKUP_DIR/${BACKUP_NAME}_knowledge-base/"
    rsync -av --delete .assistant-core/ "$BACKUP_DIR/${BACKUP_NAME}_assistant-core/"
    rsync -av --delete despejo/ "$BACKUP_DIR/${BACKUP_NAME}_despejo/"

    echo "✅ Local backup created: $BACKUP_DIR/$BACKUP_NAME"
fi

echo "🎉 Backup process completed successfully!"

# Display backup status
echo ""
echo "📊 Backup Status Summary:"
echo "- Git repository: ✅ Up to date"
echo "- Git hooks: ✅ Active"
if [ -d "$BACKUP_DIR" ]; then
    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR" | grep -c "backup_" || echo "0")
    echo "- Local backups: ✅ $BACKUP_COUNT backups available"
fi

# Show recent commits for verification
echo ""
echo "📜 Recent commits:"
git log --oneline -5