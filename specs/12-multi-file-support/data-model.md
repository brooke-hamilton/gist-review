# Data Model: Multi-File Gist Support

**Feature**: 12-multi-file-support  
**Date**: 2026-01-10

## Overview

This feature manages multiple files within a Gist and enables file-specific navigation and comment filtering.

## Entities

### GistFile

A file within a Gist.

| Field | Type | Description |
|-------|------|-------------|
| filename | string | File name (unique within Gist) |
| content | string | Raw file content |
| language | string | Programming language |
| type | string | MIME type |

### FileSelectionState

State for file selection.

| Field | Type | Description |
|-------|------|-------------|
| files | GistFile[] | All files in Gist (sorted) |
| selectedFile | string | Currently selected filename |
| isMultiFile | boolean | Whether Gist has multiple files |

## State Management

### Extended Application State

```javascript
{
  // ... existing state
  files: {
    all: [
      { filename: 'readme.md', content: '...', language: 'Markdown' },
      { filename: 'app.js', content: '...', language: 'JavaScript' }
    ],
    selected: 'readme.md',
    isMultiFile: true
  }
}
```

### Extended Comment Anchor Metadata

```yaml
---
file: readme.md          # Added field
line_start: 5
line_end: 7
offset_start: 0
offset_end: 42
selected_text: "Example text"
revision: abc123
---
```

## Functions

### extractFiles(gist: GistResponse): GistFile[]

Extracts and sorts files from Gist API response.

### selectFile(filename: string): void

Selects a file and updates URL, content, and comments.

### getSelectedFile(): string

Returns currently selected filename from URL or default.

### renderFileTabs(files: GistFile[], selected: string): void

Renders the file tab bar UI.

### isMarkdownFile(filename: string): boolean

Checks if file should be rendered as Markdown.

### renderFileContent(file: GistFile): void

Renders file content (Markdown or syntax-highlighted).

### filterCommentsByFile(comments: ParsedComment[], filename: string): ParsedComment[]

Returns comments anchored to specified file.

### updateUrlFileParam(filename: string): void

Updates URL with file parameter.

### getFileFromUrl(): string | null

Reads file parameter from URL.

### handleFileMissing(requestedFile: string, availableFiles: string[]): void

Handles case where URL file doesn't exist.
