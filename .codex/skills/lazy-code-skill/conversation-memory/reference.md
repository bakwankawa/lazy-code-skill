# Conversation Memory - Reference

## Implementation Details

### How Conversation History is Captured

The scripts provided are templates. In practice, the agent needs to:

1. **Access conversation history**: Codex's API or context provides conversation messages
2. **Extract metadata**: Workspace path, project context, file changes
3. **Format and save**: Convert to markdown with frontmatter

### Actual Save Workflow

When saving a session, the agent should:

1. **Collect conversation data**:
   - All user messages and assistant responses
   - Timestamps for each message
   - Workspace context (current directory, open files)
   - Any relevant file changes or code snippets

2. **Generate summary**:
   - Extract key topics from conversation
   - Note main accomplishments or decisions
   - Include any important context

3. **Format markdown**:
   - YAML frontmatter with metadata
   - Structured message history
   - Code blocks preserved with syntax highlighting

4. **Save to file**:
   - Use `save_session.py` script or write directly
   - Ensure `.codex/conversations/` directory exists (project-level)
   - Handle filename collisions (same hour, similar title)

### Loading and Continuing

When loading a session:

1. **Read session file**: Use `load_session.py` or read directly
2. **Parse content**: Extract frontmatter and messages
3. **Restore context**: 
   - Display conversation history
   - Note workspace/project context
   - Highlight key decisions or outcomes
4. **Continue naturally**: User can ask follow-up questions referencing previous work

### File Naming Strategy

Filename format: `YYYY-MM-DD-HH-<title-slug>.md`

- **Datetime precision**: Hour-level (e.g., `2026-02-09-14`)
- **Collision handling**: If same hour + similar title, append counter (`-1`, `-2`)
- **Title slugification**: 
  - Lowercase
  - Replace spaces with hyphens
  - Remove special characters
  - Max 50 characters

### Storage Location

Default: `.codex/conversations/` (project-level)

- Project-specific location (conversations stored per project)
- Stored in project repository (can be version controlled if desired)
- Scripts automatically find project root by locating `.codex/` directory
- Conversations are isolated per project

### Integration with Codex

The agent should:

1. **Detect save requests**: User says "save this conversation", "remember this session", etc.
2. **Auto-save option**: Offer to save at end of productive sessions
3. **Load requests**: User says "load yesterday's conversation", "continue from last time", etc.
4. **Search requests**: User asks "find conversations about X"

### Limitations and Considerations

- **File size**: Very long conversations may create large files
- **Privacy**: Conversations may contain sensitive information
- **Storage**: No automatic cleanup - user manages old sessions
- **Format**: Markdown is human-readable but may need parsing for programmatic access

### Future Enhancements

Potential improvements:

- Automatic summarization of long conversations
- Tagging/categorization system
- Export to other formats (JSON, HTML)
- Integration with Codex's native history
- Encryption for sensitive conversations
- Automatic archiving of old sessions
