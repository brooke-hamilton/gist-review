# Data Model: Create Anchored Comment

**Feature**: 9-create-anchored-comment  
**Date**: 2026-01-10

## Overview

This feature enables comment creation with structured front matter metadata. Extends the selection popover with a comment form.

## Entities

### CommentDraft

A comment being composed by the user.

| Field | Type | Description |
|-------|------|-------------|
| gistId | string | Target Gist ID |
| selection | TextSelection | Selection data from Spec 8 |
| revision | string | Current Gist revision |
| file | string | Current file name |
| text | string | Comment body text |

### CommentFrontMatter

The metadata embedded in comment body.

| Field | Type | Description |
|-------|------|-------------|
| line_start | number | Starting line number (1-indexed) |
| line_end | number | Ending line number (1-indexed) |
| offset_start | number | Start character offset |
| offset_end | number | End character offset |
| selected_text | string | The selected text |
| revision | string | Gist revision ID |
| file | string | Filename |

### CommentFormState

UI state for the comment creation form.

| Field | Type | Description |
|-------|------|-------------|
| visible | boolean | Whether form is showing |
| mode | 'edit' \| 'preview' | Current tab |
| text | string | Current input text |
| submitting | boolean | Whether submission is in progress |
| error | string \| null | Validation/submission error |

## State Management

### sessionStorage Key

`gist_review_comment_draft`

### Application State

```javascript
{
  // ... existing state
  commentForm: {
    visible: false,
    mode: 'edit',
    text: '',
    submitting: false,
    error: null,
    draft: null  // Restored from sessionStorage
  }
}
```

## Functions

### showCommentForm(selection: TextSelection): void

Opens the comment form for a selection.

### hideCommentForm(): void

Closes the form, optionally saving draft.

### setCommentMode(mode: 'edit' | 'preview'): void

Switches between edit and preview tabs.

### validateComment(text: string): boolean

Checks if comment is non-empty.

### buildFrontMatter(selection, revision, file): string

Creates YAML front matter string.

### buildCommentBody(frontMatter: string, text: string): string

Combines front matter and comment text.

### submitComment(gistId: string, body: string): Promise<GistComment>

Submits comment to GitHub API.

### saveDraft(draft: CommentDraft): void

Saves draft to sessionStorage.

### restoreDraft(): CommentDraft | null

Retrieves draft from sessionStorage.

### clearDraft(): void

Removes draft from sessionStorage.
