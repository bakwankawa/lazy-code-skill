#!/usr/bin/env python3
"""
List saved conversation sessions from .codex/conversations/ (project-level)
"""
import argparse
import re
import sys
from datetime import datetime
from pathlib import Path


def find_project_root():
    """Find project root by looking for .codex directory."""
    current = Path.cwd().resolve()
    for parent in [current] + list(current.parents):
        if (parent / ".codex").exists():
            return parent
    # Fallback to current directory if .codex not found
    return current


CONVERSATIONS_DIR = find_project_root() / ".codex" / "conversations"


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


def list_sessions(limit=None, date_filter=None):
    """List saved sessions."""
    if not CONVERSATIONS_DIR.exists():
        print("No saved conversations found.")
        return []
    
    sessions = []
    for filepath in sorted(CONVERSATIONS_DIR.glob("*.md"), reverse=True):
        try:
            content = filepath.read_text()
            frontmatter = parse_frontmatter(content)
            
            # Extract datetime from filename
            filename_match = re.match(r'(\d{4}-\d{2}-\d{2}-\d{2})', filepath.stem)
            if filename_match:
                session_date = filename_match.group(1)
                
                # Apply date filter
                if date_filter and not session_date.startswith(date_filter):
                    continue
                
                sessions.append({
                    'filename': filepath.name,
                    'path': str(filepath),
                    'datetime': session_date,
                    'title': frontmatter.get('title', filepath.stem),
                    'saved_at': frontmatter.get('saved_at', ''),
                    'summary': frontmatter.get('summary', '')
                })
        except Exception as e:
            print(f"Error reading {filepath}: {e}", file=sys.stderr)
            continue
    
    if limit:
        sessions = sessions[:limit]
    
    return sessions


def format_session_list(sessions):
    """Format sessions for display."""
    if not sessions:
        print("No sessions found.")
        return
    
    print(f"\nFound {len(sessions)} session(s):\n")
    for i, session in enumerate(sessions, 1):
        print(f"{i}. {session['datetime']} - {session['title']}")
        if session['summary']:
            print(f"   {session['summary']}")
        print(f"   {session['filename']}\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="List saved conversation sessions")
    parser.add_argument("--limit", type=int, help="Limit number of results")
    parser.add_argument("--date", help="Filter by date (YYYY-MM-DD)")
    args = parser.parse_args()
    
    sessions = list_sessions(limit=args.limit, date_filter=args.date)
    format_session_list(sessions)
