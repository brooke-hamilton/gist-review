# Data Model: Comment Thread Display

**Feature**: 11-comment-thread-display  
**Date**: 2026-01-10

## Overview

This feature manages grouping comments into threads and displaying them in a focused panel.

## Entities

### CommentThread

A group of comments anchored to the same or overlapping text.

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique thread identifier |
| comments | ParsedComment[] | Comments in the thread |
| anchorRange | {lineStart, lineEnd} | Combined anchor range |

### ThreadViewState

UI state for the thread panel.

| Field | Type | Description |
|-------|------|-------------|
| isOpen | boolean | Whether thread panel is visible |
| thread | CommentThread \| null | Currently displayed thread |
| replyText | string | Draft reply text |

## State Management

### Extended Application State

```javascript
{
  // ... existing state
  threadView: {
    isOpen: false,
    thread: null,
    replyText: ''
  },
  threads: [
    {
      id: 'thread-1',
      comments: [/* ParsedComment[] */],
      anchorRange: { lineStart: 5, lineEnd: 8 }
    }
  ]
}
```

## Functions

### groupCommentsIntoThreads(comments: ParsedComment[]): CommentThread[]

Groups comments with overlapping anchors into threads.

### openThread(commentIds: number[]): void

Opens thread panel for specified comments.

### closeThread(): void

Closes the thread panel.

### renderThreadPanel(thread: CommentThread): void

Renders the thread panel HTML.

### formatRelativeTime(date: Date): string

Formats date as relative time string.

### formatAbsoluteTime(date: Date): string

Formats date for hover tooltip.

### handleReplySubmit(): void

Submits reply using Spec 9 comment creation.

### handleClickOutside(event: MouseEvent): void

Closes panel on outside click.

### scrollToComment(commentId: number): void

Scrolls thread panel to specific comment.

### renderCommentCard(comment: ParsedComment): HTMLElement

Creates HTML for single comment in thread.
