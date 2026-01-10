# Data Model: Text Selection Capture

**Feature**: 8-text-selection-capture  
**Date**: 2026-01-10

## Overview

This feature introduces the TextSelection entity representing a user's text selection within the rendered content.

## Entities

### TextSelection

Represents a captured text selection.

| Field | Type | Description |
|-------|------|-------------|
| text | string | The selected text content |
| lineStart | number | Starting line number (1-indexed) |
| lineEnd | number | Ending line number (1-indexed) |
| offsetStart | number | Character offset at start of selection |
| offsetEnd | number | Character offset at end of selection |
| boundingRect | DOMRect | Position for popover placement |

### SelectionPopover

UI state for the selection popover.

| Field | Type | Description |
|-------|------|-------------|
| visible | boolean | Whether popover is showing |
| x | number | Horizontal position (pixels) |
| y | number | Vertical position (pixels) |
| selection | TextSelection \| null | Current selection data |

## State Management

### Selection State

```javascript
{
  selection: {
    active: false,
    data: null
  }
}

// When text is selected
{
  selection: {
    active: true,
    data: {
      text: "selected words",
      lineStart: 5,
      lineEnd: 5,
      offsetStart: 10,
      offsetEnd: 24,
      boundingRect: { top: 100, left: 200, ... }
    }
  }
}
```

## Functions

### handleSelectionChange(): void

Event handler for selection changes. Debounced.

### getSelectionData(): TextSelection | null

Extracts selection metadata from current browser selection.

### getLineNumber(node: Node): number | null

Finds the source line number for a DOM node.

### getCharacterOffset(container: Node, offset: number): number

Calculates character offset relative to line.

### showSelectionPopover(selection: TextSelection): void

Displays the popover near the selection.

### hideSelectionPopover(): void

Hides the popover when selection is cleared.

### isValidSelection(text: string): boolean

Checks if selection meets minimum requirements.

## Line Mapping

### During Markdown Rendering

The Markdown renderer (Spec 4) must be extended to add `data-line` attributes:

```javascript
// Each block element gets a line attribute
<h1 data-line="1">Heading</h1>
<p data-line="3">Paragraph text...</p>
<pre data-line="5"><code>...</code></pre>
```

### Line Number Extraction

```javascript
function getLineNumber(node) {
  // Walk up DOM tree to find line marker
  let current = node.nodeType === Node.TEXT_NODE 
    ? node.parentElement 
    : node;
    
  while (current && !current.dataset?.line) {
    current = current.parentElement;
  }
  
  return current ? parseInt(current.dataset.line, 10) : null;
}
```
