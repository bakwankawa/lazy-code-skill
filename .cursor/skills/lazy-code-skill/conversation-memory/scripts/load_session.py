#!/usr/bin/env python3
"""
Load and display a saved conversation session from .cursor/conversations/ (project-level)
"""
import argparse
import re
import sys
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


def parse_frontmatter(content):
    """Extract YAML frontmatter from markdown."""
    match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
    if not match:
        return {}
    
    frontmatter = {}
    for line in match.group(1).split('\n'):
        if ':' in line:
            key, value = line.split(':', 1)
            frontmatter[key.strip()] = value.strip().strip('"\'')
    return frontmatter


def load_session(filename):
    """Load a session file."""
    filepath = CONVERSATIONS_DIR / filename
    
    if not filepath.exists():
        print(f"Session not found: {filename}", file=sys.stderr)
        return None
    
    content = filepath.read_text()
    frontmatter = parse_frontmatter(content)
    
    # Extract body (everything after frontmatter)
    body_match = re.search(r'^---\n.*?\n---\n(.*)', content, re.DOTALL)
    body = body_match.group(1) if body_match else content
    
    return {
        'filename': filename,
        'path': str(filepath),
        'metadata': frontmatter,
        'content': body,
        'full_content': content
    }


def display_session(session):
    """Display session content."""
    if not session:
        return
    
    print(f"\n{'='*60}")
    print(f"Session: {session['metadata'].get('title', 'Untitled')}")
    print(f"Saved: {session['metadata'].get('saved_at', 'Unknown')}")
    print(f"File: {session['filename']}")
    print(f"{'='*60}\n")
    print(session['content'])


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Load a saved conversation session")
    parser.add_argument("filename", help="Session filename")
    args = parser.parse_args()
    
    session = load_session(args.filename)
    if session:
        display_session(session)
        # Also output full content for agent to use
        print("\n---\nFull session content available for continuation.")
