---
name: conversation-memory
description: Store and retrieve conversation session context for continuity across sessions (project-level). Saves completed conversations organized by datetime (hour-level granularity) to .cursor/conversations/ and enables loading previous sessions to continue context. Use when the user wants to save a conversation, load a previous session, list past conversations, or continue work from a stored session.
---

# Conversation Memory

Store conversation sessions for later retrieval and continuation. Sessions are organized by datetime at hour-level granularity (YYYY-MM-DD-HH format).

## Storage Structure

Sessions are stored in `.cursor/conversations/` (project-level) with this structure:

```
.cursor/conversations/
├── YYYY-MM-DD-HH-session-title.md
├── YYYY-MM-DD-HH-another-session.md
└── ...
```

**Filename format**: `YYYY-MM-DD-HH-<slugified-title>.md`
- Datetime: `YYYY-MM-DD-HH` (e.g., `2026-02-09-14`)
- Title: Slugified from user-provided title or auto-generated from first message

## Saving a Conversation

When the user wants to save the current conversation:

1. **Generate filename**:
   - Extract datetime: current hour in `YYYY-MM-DD-HH` format
   - Extract title: user-provided title, or generate from first user message (slugify, max 50 chars)
   - Format: `YYYY-MM-DD-HH-<title>.md`

2. **Collect conversation data**:
   - Read conversation history from current session
   - Extract all user messages and assistant responses with timestamps
   - Capture workspace context (current directory, project info)
   - Generate summary of key topics and decisions

3. **Save conversation**:
   - Create `.cursor/conversations/` directory if needed (project-level)
   - Write markdown file with frontmatter and full conversation history
   - Use format specified in "Session File Format" section below
   - Handle filename collisions (append `-1`, `-2` if same hour+title exists)

4. **Confirm save**:
   - Show saved path and filename
   - Display summary of what was saved

## Loading a Previous Session

When the user wants to continue from a stored session:

1. **List available sessions**:
   - Run: `python .cursor/skills/lazy-code-skill/conversation-memory/scripts/list_sessions.py` (from project root)
   - Shows recent sessions with datetime and title

2. **Load session**:
   - User selects by filename or datetime
   - Run: `python .cursor/skills/lazy-code-skill/conversation-memory/scripts/load_session.py <filename>` (from project root)
   - Display conversation history and context
   - Continue from where it left off

## Searching Sessions

To find sessions by date, title, or content:

- Run: `python .cursor/skills/lazy-code-skill/conversation-memory/scripts/search_sessions.py <query>` (from project root)
- Returns matching sessions with preview

## Session File Format

Each saved session uses this structure:

```markdown
---
saved_at: YYYY-MM-DD HH:MM:SS
session_start: YYYY-MM-DD HH:MM:SS
title: Session Title
summary: Brief summary of conversation topics
---

# Conversation Session: [Title]

## Context
[Any relevant context, workspace info, or initial state]

## Messages

### User: [timestamp]
[User message content]

### Assistant: [timestamp]
[Assistant response]

...
```

## Utility Scripts

The agent can use these scripts or implement the logic directly:

**save_session.py**: Template script for saving (agent should write markdown directly)
```bash
# Run from project root
python .cursor/skills/lazy-code-skill/conversation-memory/scripts/save_session.py [--title "Title"]
```

**list_sessions.py**: List all saved sessions
```bash
# Run from project root
python .cursor/skills/lazy-code-skill/conversation-memory/scripts/list_sessions.py [--limit N] [--date YYYY-MM-DD]
```

**load_session.py**: Load and display a session
```bash
# Run from project root
python .cursor/skills/lazy-code-skill/conversation-memory/scripts/load_session.py <filename>
```

**search_sessions.py**: Search sessions by content
```bash
# Run from project root
python .cursor/skills/lazy-code-skill/conversation-memory/scripts/search_sessions.py <query>
```

**Note**: The agent should write markdown files directly when saving, using the conversation history available in the current session context.

## Workflow Examples

**Saving at end of session:**
- User: "Save this conversation"
- Agent saves with auto-generated title from first message
- Confirms save location

**Continuing previous work:**
- User: "Load yesterday's conversation about the API"
- Agent lists recent sessions
- User selects or agent finds matching session
- Agent loads and displays context
- Conversation continues

**Finding old sessions:**
- User: "Show me conversations from last week about authentication"
- Agent searches by date and content
- Displays matching sessions
