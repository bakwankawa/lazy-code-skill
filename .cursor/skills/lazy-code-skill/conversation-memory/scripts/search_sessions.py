#!/usr/bin/env python3
"""
Search saved conversation sessions by content from .cursor/conversations/ (project-level)
"""
import argparse
import re
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


def search_sessions(query, case_sensitive=False):
    """Search sessions by content."""
    if not CONVERSATIONS_DIR.exists():
        return []
    
    matches = []
    query_lower = query.lower() if not case_sensitive else query
    
    for filepath in sorted(CONVERSATIONS_DIR.glob("*.md"), reverse=True):
        try:
            content = filepath.read_text()
            frontmatter = parse_frontmatter(content)
            
            # Search in title, summary, and content
            search_text = f"{frontmatter.get('title', '')} {frontmatter.get('summary', '')} {content}"
            
            if not case_sensitive:
                search_text = search_text.lower()
            
            if query_lower in search_text:
                # Extract preview around match
                match_index = search_text.find(query_lower)
                start = max(0, match_index - 100)
                end = min(len(content), match_index + len(query) + 100)
                preview = content[start:end].replace('\n', ' ')
                
                matches.append({
                    'filename': filepath.name,
                    'path': str(filepath),
                    'title': frontmatter.get('title', filepath.stem),
                    'saved_at': frontmatter.get('saved_at', ''),
                    'preview': preview
                })
        except Exception as e:
            continue
    
    return matches


def format_search_results(matches, query):
    """Format search results for display."""
    if not matches:
        print(f"No sessions found matching '{query}'")
        return
    
    print(f"\nFound {len(matches)} matching session(s) for '{query}':\n")
    for i, match in enumerate(matches, 1):
        print(f"{i}. {match['title']}")
        print(f"   Saved: {match['saved_at']}")
        print(f"   File: {match['filename']}")
        print(f"   Preview: ...{match['preview']}...\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Search saved conversation sessions")
    parser.add_argument("query", help="Search query")
    parser.add_argument("--case-sensitive", action="store_true", help="Case-sensitive search")
    args = parser.parse_args()
    
    matches = search_sessions(args.query, case_sensitive=args.case_sensitive)
    format_search_results(matches, args.query)
