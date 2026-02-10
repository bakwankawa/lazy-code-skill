#!/usr/bin/env python3
"""
Save current conversation session to .cursor/conversations/ (project-level)
"""
import argparse
import json
import os
import re
from datetime import datetime
from pathlib import Path


def find_project_root():
    """Find project root by looking for .cursor directory."""
    current = Path.cwd().resolve()
    for parent in [current] + list(current.parents):
        if (parent / ".cursor").exists():
            return parent
    # Fallback to current directory if .cursor not found
    return current


CONVERSATIONS_DIR = find_project_root() / ".cursor" / "conversations"


def slugify(text, max_length=50):
    """Convert text to URL-friendly slug."""
    text = re.sub(r'[^\w\s-]', '', text.lower())
    text = re.sub(r'[-\s]+', '-', text)
    return text[:max_length].strip('-')


def generate_filename(title=None, first_message=None):
    """Generate filename from datetime and title."""
    now = datetime.now()
    datetime_str = now.strftime("%Y-%m-%d-%H")
    
    if title:
        title_slug = slugify(title)
    elif first_message:
        # Extract first ~50 chars from first message
        title_slug = slugify(first_message[:100])
    else:
        title_slug = "conversation"
    
    return f"{datetime_str}-{title_slug}.md"


def save_session(title=None):
    """Save current conversation session."""
    CONVERSATIONS_DIR.mkdir(parents=True, exist_ok=True)
    
    # Try to read conversation history from Cursor's context
    # This is a placeholder - actual implementation depends on Cursor's API
    # For now, we'll create a template that the agent can populate
    
    filename = generate_filename(title)
    filepath = CONVERSATIONS_DIR / filename
    
    # Check if file exists (same hour, similar title)
    if filepath.exists():
        # Append counter
        base = filepath.stem
        counter = 1
        while filepath.exists():
            filepath = CONVERSATIONS_DIR / f"{base}-{counter}.md"
            counter += 1
    
    # Create session content
    now = datetime.now()
    session_start = now  # In real implementation, get from conversation metadata
    
    content = f"""---
saved_at: {now.strftime("%Y-%m-%d %H:%M:%S")}
session_start: {session_start.strftime("%Y-%m-%d %H:%M:%S")}
title: {title or "Untitled Conversation"}
summary: Conversation session saved automatically
---

# Conversation Session: {title or "Untitled Conversation"}

## Context
[Workspace and context information will be populated by the agent]

## Messages

[Conversation messages will be populated by the agent]

---
*Session saved at {now.strftime("%Y-%m-%d %H:%M:%S")}*
"""
    
    filepath.write_text(content)
    print(f"Session saved to: {filepath}")
    return str(filepath)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Save current conversation session")
    parser.add_argument("--title", help="Title for the session")
    args = parser.parse_args()
    
    save_session(args.title)
