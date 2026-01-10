# Data Model: Gist Revision Selector

**Feature**: 5-gist-revision-selector  
**Date**: 2026-01-10

## Overview

This feature introduces the GistRevision entity and extends application state to track the currently selected revision.

## Entities

### GistRevision

Represents a historical snapshot of a Gist.

| Field | Type | Description |
|-------|------|-------------|
| version | string | Unique revision identifier (SHA) |
| committed_at | string | ISO 8601 timestamp of the commit |
| user | GistOwner | User who made the revision |
| change_status | ChangeStatus | Summary of changes in this revision |

### ChangeStatus

Summary of changes in a revision.

| Field | Type | Description |
|-------|------|-------------|
| additions | number | Lines added |
| deletions | number | Lines deleted |
| total | number | Total lines changed |

## State Management

### Extended Application State

```javascript
{
  state: 'loaded',
  gistId: 'abc123',
  gist: { /* Gist object */ },
  revisions: [
    { version: 'v1...', committed_at: '...', ... },
    { version: 'v2...', committed_at: '...', ... }
  ],
  currentRevision: 'v2...',  // Currently displayed version
  isLatest: true             // Whether viewing latest
}
```

### URL State

```
?gist={gist_id}&rev={revision_version}
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| gist | Yes | Gist identifier |
| rev | No | Revision version. Omit for latest. |

## Functions

### getRevisionHistory(gist: Gist): GistRevision[]

Extracts revision history from Gist object.

### fetchRevision(gistId: string, version: string): Promise<Gist>

Fetches Gist content at a specific revision.

### formatRevisionTimestamp(iso: string): string

Formats revision timestamp for display.

### updateUrlWithRevision(gistId: string, version: string): void

Updates browser URL and history with revision.

### handleRevisionSelect(version: string): void

Handles dropdown selection change.

### renderRevisionSelector(revisions: GistRevision[], current: string): void

Renders the dropdown UI.
