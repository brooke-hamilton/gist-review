# Research: Accessibility Enhancements

**Feature**: 14-accessibility-enhancements  
**Date**: 2026-01-10

## Research Tasks

### 1. Focus Indicator Styling

**Decision**: Use 2px solid outline with 2px offset, high-contrast blue color.

**CSS**:
```css
:focus-visible {
  outline: 2px solid #005fcc;
  outline-offset: 2px;
}

/* Ensure high contrast in dark mode */
@media (prefers-color-scheme: dark) {
  :focus-visible {
    outline-color: #58a6ff;
  }
}
```

**Rationale**: `:focus-visible` shows focus only for keyboard users, not mouse clicks.

### 2. Skip Link Implementation

**Decision**: Hidden skip link that appears on focus.

**HTML**:
```html
<a href="#main-content" class="skip-link">Skip to content</a>
```

**CSS**:
```css
.skip-link {
  position: absolute;
  top: -100px;
  left: 16px;
  background: var(--bg-primary);
  padding: 8px 16px;
  z-index: 1000;
}

.skip-link:focus {
  top: 16px;
}
```

### 3. ARIA Labels for Custom Components

**Decision**: Add descriptive aria-label to all interactive elements.

**Examples**:
```html
<select aria-label="Select Gist revision">
<nav aria-label="File tabs" role="tablist">
<button aria-label="Close comment thread">
<div class="comment-highlight" role="button" aria-label="View 3 comments on this selection">
```

### 4. ARIA Live Regions

**Decision**: Use `aria-live="polite"` for most updates, `assertive` for errors.

**HTML**:
```html
<div id="status-region" aria-live="polite" aria-atomic="true" class="sr-only"></div>
<div id="error-region" aria-live="assertive" aria-atomic="true" class="sr-only"></div>
```

**Usage**:
```javascript
function announceStatus(message) {
  document.getElementById('status-region').textContent = message;
}

function announceError(message) {
  document.getElementById('error-region').textContent = message;
}
```

### 5. Focus Trapping in Modals

**Decision**: Trap focus within modal using event listener.

**Implementation**:
```javascript
function trapFocus(modal) {
  const focusable = modal.querySelectorAll(
    'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
  );
  const first = focusable[0];
  const last = focusable[focusable.length - 1];
  
  modal.addEventListener('keydown', (e) => {
    if (e.key === 'Tab') {
      if (e.shiftKey && document.activeElement === first) {
        e.preventDefault();
        last.focus();
      } else if (!e.shiftKey && document.activeElement === last) {
        e.preventDefault();
        first.focus();
      }
    }
  });
}
```

### 6. Keyboard Shortcuts

**Decision**: Minimal shortcuts with help dialog.

| Key | Action |
|-----|--------|
| Escape | Close modal/popover |
| / | Focus search (if present) |
| ? | Show keyboard help |

### 7. Highlight Keyboard Navigation

**Decision**: Make highlights tabbable with role="button".

```javascript
highlights.forEach((el, index) => {
  el.setAttribute('tabindex', '0');
  el.setAttribute('role', 'button');
  el.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      openCommentThread(el);
    }
  });
});
```

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Focus Style | 2px solid outline, offset | Clear visibility |
| Skip Link | Hidden until focused | Standard pattern |
| ARIA Labels | Descriptive on all controls | Screen reader support |
| Live Regions | polite/assertive | Appropriate urgency |
| Focus Trap | Tab key interception | Modal accessibility |
| Shortcuts | Esc, /, ? | Minimal, discoverable |
| Highlights | tabindex + role=button | Keyboard accessible |
