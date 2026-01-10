# Data Model: Markdown Rendering with Sanitization

**Feature**: 4-markdown-rendering  
**Date**: 2026-01-10

## Overview

This feature transforms raw Markdown content into safely rendered HTML. No new persistent entities are introduced; the rendering is a pure transformation function.

## Entities

*No new persistent entities. This feature processes existing Gist content.*

## Data Transformations

### Rendering Pipeline

```
Raw Markdown (string)
    ↓
marked.js (parse to HTML)
    ↓
highlight.js (syntax highlight code blocks)
    ↓
DOMPurify (sanitize HTML)
    ↓
Safe HTML (string)
    ↓
DOM insertion
```

### RenderOptions

Configuration for the rendering pipeline.

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| sanitize | boolean | true | Enable DOMPurify sanitization |
| highlight | boolean | true | Enable syntax highlighting |
| gfm | boolean | true | Enable GitHub Flavored Markdown |
| breaks | boolean | false | Convert newlines to `<br>` |

## Functions

### renderMarkdown(content: string, options?: RenderOptions): string

Main entry point. Converts Markdown to sanitized HTML.

### configureMarked(): void

Sets up marked.js with custom renderer for links.

### configureHighlight(): void

Sets up highlight.js with common languages.

### sanitizeHtml(html: string): string

Wraps DOMPurify.sanitize with appropriate configuration.

## State Management

No state changes. This feature is purely functional transformation.

The rendered content is inserted into the existing main content area established in Spec 1.
