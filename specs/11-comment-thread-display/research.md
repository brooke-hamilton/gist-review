# Research: Comment Thread Display

**Feature**: 11-comment-thread-display  
**Date**: 2026-01-10

## Research Tasks

### 1. Thread Grouping Algorithm

**Decision**: Group comments by overlapping anchor ranges using interval intersection.

**Algorithm**:
```javascript
function groupCommentsIntoThreads(comments) {
  // Sort by line start
  const sorted = [...comments].sort((a, b) => a.lineStart - b.lineStart);
  const threads = [];
  
  for (const comment of sorted) {
    const overlapping = threads.find(t => 
      t.some(c => rangesOverlap(c.anchor, comment.anchor))
    );
    if (overlapping) {
      overlapping.push(comment);
    } else {
      threads.push([comment]);
    }
  }
  return threads;
}

function rangesOverlap(a, b) {
  return a.lineEnd >= b.lineStart && b.lineEnd >= a.lineStart;
}
```

**Rationale**: Detects overlapping anchors and groups them as threads.

### 2. Relative Time Formatting

**Decision**: Use Intl.RelativeTimeFormat for relative timestamps.

**Implementation**:
```javascript
function formatRelativeTime(date) {
  const rtf = new Intl.RelativeTimeFormat('en', { numeric: 'auto' });
  const now = Date.now();
  const diff = date.getTime() - now;
  const seconds = Math.round(diff / 1000);
  const minutes = Math.round(seconds / 60);
  const hours = Math.round(minutes / 60);
  const days = Math.round(hours / 24);
  
  if (Math.abs(days) >= 1) return rtf.format(days, 'day');
  if (Math.abs(hours) >= 1) return rtf.format(hours, 'hour');
  if (Math.abs(minutes) >= 1) return rtf.format(minutes, 'minute');
  return rtf.format(seconds, 'second');
}
```

**Rationale**: Native API, well-supported, no dependencies needed.

### 3. Focused View UI Pattern

**Decision**: Overlay panel within sidebar that expands to show thread.

**Layout**:
```html
<div class="thread-panel">
  <button class="close-thread">&times;</button>
  <div class="thread-comments">
    <!-- Comment cards here -->
  </div>
  <div class="thread-reply">
    <textarea placeholder="Reply..."></textarea>
    <button>Submit</button>
  </div>
</div>
```

### 4. Closing the Focused View

**Decision**: Support both click-outside and explicit close button.

**Implementation**:
```javascript
document.addEventListener('click', (e) => {
  const panel = document.querySelector('.thread-panel');
  if (panel && !panel.contains(e.target) && 
      !e.target.closest('.comment-highlight')) {
    closeThreadPanel();
  }
});
```

### 5. Large Thread Handling

**Decision**: Use CSS overflow-y scroll with max-height.

**CSS**:
```css
.thread-comments {
  max-height: 60vh;
  overflow-y: auto;
}
```

### 6. Comment Body Rendering

**Decision**: Render comment bodies as Markdown using marked.js + DOMPurify.

**Rationale**: Consistent with Gist content rendering.

### 7. Reply Input

**Decision**: Show reply textarea only for authenticated users. Use existing comment creation flow from Spec 9.

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Grouping | Interval overlap detection | Accurate thread grouping |
| Timestamps | Intl.RelativeTimeFormat | Native, no dependencies |
| UI Pattern | Overlay panel in sidebar | Focused experience |
| Closing | Click-outside + button | Multiple dismiss methods |
| Large Threads | Scrollable container | Handles 10+ comments |
| Comment Body | marked.js + DOMPurify | Consistent rendering |
| Reply | Conditional on auth | Reuses Spec 9 flow |
