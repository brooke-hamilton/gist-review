# Data Model: URL Parameter Routing

**Feature**: 2-url-parameter-routing  
**Date**: 2026-01-10

## Overview

This feature introduces URL-based state for identifying which Gist to display. The Gist ID becomes the primary identifier for the application state.

## Entities

### GistIdentifier

Represents the extracted Gist ID from URL parameters.

| Field | Type | Description |
|-------|------|-------------|
| gistId | string \| null | The extracted Gist ID, or null if not provided |
| rawInput | string \| null | The original input from URL parameter |
| isFullUrl | boolean | Whether the input was a full URL vs bare ID |

## State Management

### URL State

The application state is driven by URL query parameters:

```
?gist={gist_id_or_url}
```

| Parameter | Required | Description |
|-----------|----------|-------------|
| gist | No | Bare Gist ID or full GitHub Gist URL |

### Application State

```javascript
// Possible states
{
  state: 'empty',      // No gist parameter provided
  gistId: null
}

{
  state: 'identified', // Gist ID extracted from URL
  gistId: 'abc123'
}
```

## Functions

### parseGistParameter(urlParams: URLSearchParams): GistIdentifier

Extracts and processes the `gist` query parameter.

### extractGistIdFromUrl(url: string): string

Extracts the Gist ID from a full GitHub Gist URL.

### displayGistId(gistId: string): void

Updates the DOM to display the extracted Gist ID.

### displayGuidanceMessage(): void

Shows the helpful message when no Gist parameter is provided.
