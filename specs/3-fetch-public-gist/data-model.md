# Data Model: Fetch and Display Public Gist

**Feature**: 3-fetch-public-gist  
**Date**: 2026-01-10

## Overview

This feature introduces the Gist and GistFile entities representing data fetched from the GitHub API.

## Entities

### Gist

Represents a GitHub Gist with its metadata and files.

| Field | Type | Description |
|-------|------|-------------|
| id | string | Unique Gist identifier |
| description | string \| null | Gist description |
| public | boolean | Whether the Gist is public |
| files | Record<string, GistFile> | Files in the Gist, keyed by filename |
| history | GistRevision[] | Revision history (used in Spec 5) |
| owner | GistOwner \| null | Gist owner information |
| created_at | string | ISO 8601 creation timestamp |
| updated_at | string | ISO 8601 last update timestamp |

### GistFile

Represents an individual file within a Gist.

| Field | Type | Description |
|-------|------|-------------|
| filename | string | Name of the file |
| type | string | MIME type (e.g., "text/plain") |
| language | string \| null | Detected language (e.g., "Markdown") |
| content | string | Raw file content |
| size | number | File size in bytes |
| raw_url | string | Direct URL to raw file content |

### GistOwner

Represents the Gist owner.

| Field | Type | Description |
|-------|------|-------------|
| login | string | GitHub username |
| avatar_url | string | Profile picture URL |

## State Management

### Application State

```javascript
// Possible states
{
  state: 'empty',       // No gist parameter
  gistId: null,
  gist: null
}

{
  state: 'loading',     // Fetching gist
  gistId: 'abc123',
  gist: null
}

{
  state: 'loaded',      // Gist successfully loaded
  gistId: 'abc123',
  gist: { /* Gist object */ }
}

{
  state: 'error',       // Fetch failed
  gistId: 'abc123',
  gist: null,
  error: {
    type: 'not_found' | 'rate_limited' | 'private' | 'network' | 'timeout',
    message: 'User-friendly message',
    resetTime: Date | null  // For rate limit errors
  }
}
```

## Functions

### fetchGist(gistId: string): Promise<Gist>

Fetches a Gist from the GitHub API.

### getFirstFile(gist: Gist): GistFile | null

Returns the first file alphabetically from a Gist.

### displayGistContent(content: string): void

Displays raw Gist content in the main area.

### displayError(error: GistError): void

Shows error message with appropriate styling.

### displayLoading(): void

Shows loading indicator.
