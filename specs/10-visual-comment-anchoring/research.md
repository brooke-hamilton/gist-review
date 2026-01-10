# Research: Visual Comment Anchoring

**Feature**: 10-visual-comment-anchoring  
**Date**: 2026-01-10

## Research Tasks

### 1. Text Highlighting Approach

**Decision**: Use CSS `::highlight` pseudo-element with Custom Highlights API, with fallback to `<mark>` wrapper elements.

**Primary Approach (Modern Browsers)**:

```javascript
const highlight = new Highlight();
CSS.highlights.set('comment-anchor', highlight);

// Add ranges to highlight
highlight.add(range);
```

**Fallback (Older Browsers)**:

```javascript
// Wrap text in <mark> elements
const mark = document.createElement('mark');
mark.className = 'comment-highlight';
range.surroundContents(mark);
```

**Rationale**:

- Custom Highlights API is non-destructive (doesn't modify DOM)
- Falls back gracefully to mark elements
- Both can be styled via CSS

### 2. Highlight Styling

**Decision**: Semi-transparent yellow/amber background with hover effect.

**CSS**:

```css
::highlight(comment-anchor) {
  background-color: rgba(255, 213, 79, 0.4);
}

/* Fallback */
.comment-highlight {
  background-color: rgba(255, 213, 79, 0.4);
  cursor: pointer;
}

.comment-highlight:hover {
  background-color: rgba(255, 213, 79, 0.6);
}
```

### 3. Anchor Position Mapping

**Decision**: Use line numbers and character offsets from comment metadata to find DOM positions.

**Process**:

1. Find element with matching `data-line` attribute
2. Walk text nodes to find character offset
3. Create Range spanning the selection
4. Apply highlight to range

### 4. Revision Filtering

**Decision**: Filter comments by `revision` field in metadata before rendering highlights.

**Rationale**:

- Only show highlights for current revision
- Required by spec FR-003
- Prevents confusion from outdated anchors

### 5. Click Handling

**Decision**: Use event delegation on content area, check if click target is within highlight.

**Implementation**:

```javascript
contentArea.addEventListener('click', (e) => {
  const highlight = e.target.closest('.comment-highlight');
  if (highlight) {
    const commentIds = highlight.dataset.commentIds.split(',');
    if (commentIds.length > 1) {
      showCommentSelector(commentIds, e);
    } else {
      focusComment(commentIds[0]);
    }
  }
});
```

### 6. Overlapping Highlights

**Decision**: For overlapping anchors, show popup menu listing all comments when clicked.

**Rationale**:

- Required by spec FR-007
- Users can choose which comment to focus
- Avoids confusing merged highlights

### 7. Orphaned Comments

**Decision**: Display orphaned comments in sidebar with warning icon and muted style.

**Rationale**:

- Anchor text may no longer exist in new revisions
- Users should still see the comment
- Visual indicator explains why no highlight exists

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Highlighting | Custom Highlights API + fallback | Non-destructive, modern |
| Style | Yellow/amber semi-transparent | Clear but not overwhelming |
| Positioning | Line + offset from metadata | Matches creation data |
| Filtering | By revision | Current revision only |
| Click | Event delegation | Performance, simplicity |
| Overlaps | Popup menu to choose | User control |
| Orphans | Warning icon in sidebar | Graceful degradation |
