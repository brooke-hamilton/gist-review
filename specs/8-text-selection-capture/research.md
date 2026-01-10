# Research: Text Selection Capture

**Feature**: 8-text-selection-capture  
**Date**: 2026-01-10

## Research Tasks

### 1. Selection API

**Decision**: Use native `window.getSelection()` API for text selection tracking.

**Rationale**: 
- Standard browser API
- Provides Range objects for precise positioning
- Works across all modern browsers

**Key Methods**:
```javascript
const selection = window.getSelection();
const text = selection.toString();
const range = selection.getRangeAt(0);
const rect = range.getBoundingClientRect();
```

### 2. Selection Event Handling

**Decision**: Listen for `selectionchange` event on document, debounced.

**Rationale**:
- Fires on any selection change
- Works for mouse and keyboard selection
- Debouncing prevents excessive processing

**Implementation**:
```javascript
document.addEventListener('selectionchange', debounce(() => {
  const selection = window.getSelection();
  // Process selection
}, 100));
```

### 3. Line Number Mapping

**Decision**: Add `data-line` attributes to rendered HTML elements during Markdown parsing.

**Rationale**:
- Creates explicit mapping from DOM to source
- Can traverse up DOM tree to find nearest line marker
- Custom marked.js renderer can add attributes

**Implementation**:
```javascript
// During Markdown rendering
renderer.paragraph = function(text) {
  return `<p data-line="${currentLine}">${text}</p>`;
};

// During selection
function getLineNumber(node) {
  const lineElement = node.closest('[data-line]');
  return lineElement ? parseInt(lineElement.dataset.line) : null;
}
```

### 4. Character Offset Calculation

**Decision**: Calculate offsets relative to text content of the containing line element.

**Rationale**:
- Offsets should be meaningful for anchor recreation
- Line-relative offsets are simpler than document-relative
- Works with multi-element lines (bold, italic, etc.)

**Challenges**:
- Selections crossing element boundaries
- Hidden elements (e.g., collapsed whitespace)

### 5. Popover Positioning

**Decision**: Position popover above selected text using `getBoundingClientRect()`.

**Rationale**:
- Appears near the selection for context
- Doesn't obscure selected text
- Native positioning without library

**CSS**:
```css
.selection-popover {
  position: fixed;
  transform: translateX(-50%);
  /* Positioned via JavaScript */
}
```

### 6. Selection Validation

**Decision**: Require minimum 3 characters and ignore whitespace-only selections.

**Rationale**:
- Prevents accidental single-character triggers
- Whitespace selections have no meaningful context
- Required by spec FR-001a, FR-001b

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Selection API | Native `getSelection()` | Standard, reliable |
| Event | `selectionchange`, debounced | Captures all selection changes |
| Line Mapping | `data-line` attributes | Explicit DOM-to-source mapping |
| Offsets | Line-relative | Simpler, meaningful |
| Popover | Fixed positioning | Near selection |
| Validation | Min 3 chars, no whitespace | Spec requirement |
