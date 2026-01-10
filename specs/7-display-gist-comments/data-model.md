# Data Model: Fetch and Display Gist Comments

**Feature**: 7-display-gist-comments  
**Date**: 2026-01-10

## Overview

This feature introduces the GistComment entity with parsed front matter metadata for anchor positioning.

## Entities

### GistComment

A comment on a Gist with optional anchor metadata.

| Field | Type | Description |
|-------|------|-------------|
| id | number | GitHub comment ID |
| body | string | Raw comment body (including front matter) |
| user | CommentAuthor | Author information |
| created_at | string | ISO 8601 creation timestamp |
| updated_at | string | ISO 8601 update timestamp |

### CommentAuthor

Author information for a comment.

| Field | Type | Description |
|-------|------|-------------|
| login | string | GitHub username |
| avatar_url | string | Profile picture URL |

### ParsedComment

Processed comment with extracted metadata.

| Field | Type | Description |
|-------|------|-------------|
| id | number | Original comment ID |
| author | CommentAuthor | Author information |
| content | string | Comment body without front matter |
| metadata | AnchorMetadata \| null | Parsed front matter, if present |
| created_at | string | Creation timestamp |

### AnchorMetadata

Metadata from comment front matter (schema from Spec 9).

| Field | Type | Description |
|-------|------|-------------|
| line_start | number | Starting line number |
| line_end | number | Ending line number |
| offset_start | number | Start character offset |
| offset_end | number | End character offset |
| selected_text | string | The selected text |
| revision | string | Gist revision ID |
| file | string | Filename in multi-file Gist |

## State Management

### Extended Application State

```javascript
{
  // ... existing state from previous specs
  comments: {
    loading: boolean,
    error: string | null,
    items: ParsedComment[],
    anchored: ParsedComment[],    // Sorted by line number
    unanchored: ParsedComment[]   // Sorted chronologically
  },
  sidebar: {
    expanded: boolean,
    focusedCommentId: number | null
  }
}
```

## Functions

### fetchComments(gistId: string): Promise<GistComment[]>

Fetches all comments for a Gist.

### parseComment(comment: GistComment): ParsedComment

Parses front matter and extracts metadata.

### parseFrontMatter(body: string): { metadata, content }

Extracts YAML/JSON front matter from comment body.

### groupAndSortComments(comments: ParsedComment[]): { anchored, unanchored }

Separates and sorts comments for display.

### renderCommentSidebar(comments: ParsedComment[]): void

Renders the comment sidebar UI.

### toggleSidebar(): void

Expands or collapses the sidebar.
