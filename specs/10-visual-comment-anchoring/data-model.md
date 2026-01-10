# Data Model: Visual Comment Anchoring

**Feature**: 10-visual-comment-anchoring  
**Date**: 2026-01-10

## Overview

This feature adds visual highlight rendering based on comment anchor metadata and manages highlight-to-comment navigation.

## Entities

### HighlightRegion

A highlighted region in the rendered content.

| Field | Type | Description |
|-------|------|-------------|
| range | Range | DOM Range object for the highlight |
| commentIds | number[] | IDs of comments anchored here |
| lineStart | number | Starting line number |
| lineEnd | number | Ending line number |

### CommentAnchorState

State for managing highlights.

| Field | Type | Description |
|-------|------|-------------|
| highlights | HighlightRegion[] | All active highlights |
| orphanedComments | ParsedComment[] | Comments with invalid anchors |
| focusedCommentId | number \| null | Currently focused comment |

## State Management

### Extended Application State

```javascript
{
  // ... existing state
  anchoring: {
    highlights: [
      { range: Range, commentIds: [1, 2], lineStart: 5, lineEnd: 7 }
    ],
    orphanedComments: [
      { id: 3, /* ... */ }  // Anchor text doesn't exist
    ],
    focusedCommentId: null
  }
}
```

## Functions

### renderHighlights(comments: ParsedComment[], revision: string): void

Creates highlights for all anchored comments matching the current revision.

### clearHighlights(): void

Removes all existing highlights.

### findTextRange(lineStart, lineEnd, offsetStart, offsetEnd): Range | null

Locates DOM range for anchor metadata.

### applyHighlight(range: Range, commentIds: number[]): void

Applies visual highlight to a range.

### handleHighlightClick(event: MouseEvent): void

Handles click on highlighted region.

### showCommentSelector(commentIds: number[], position: {x, y}): void

Shows popup for choosing among overlapping comments.

### focusComment(commentId: number): void

Scrolls sidebar and highlights comment.

### markOrphanedComments(comments: ParsedComment[]): void

Identifies and marks comments with invalid anchors.

### updateHighlightsForRevision(revision: string): void

Refreshes highlights when revision changes.
