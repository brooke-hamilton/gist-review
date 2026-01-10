# Research: Markdown Rendering with Sanitization

**Feature**: 4-markdown-rendering  
**Date**: 2026-01-10

## Research Tasks

### 1. Markdown Library Selection

**Decision**: Use marked.js for Markdown parsing.

**Rationale**: 
- Lightweight (~47KB minified)
- Full GitHub Flavored Markdown (GFM) support
- Highly configurable
- Active maintenance
- No build step required, available via CDN

**Alternatives Considered**:
- markdown-it - Good alternative, slightly larger, more plugins
- showdown - Older, less active
- remark - Requires build pipeline, rejected

**CDN Source**:
```html
<script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
```

### 2. HTML Sanitization Library

**Decision**: Use DOMPurify for HTML sanitization.

**Rationale**:
- Industry-standard XSS prevention
- Lightweight (~13KB minified)
- Highly configurable whitelist
- Used by major projects (WordPress, etc.)
- Required by constitution security requirements

**CDN Source**:
```html
<script src="https://cdn.jsdelivr.net/npm/dompurify/dist/purify.min.js"></script>
```

### 3. Syntax Highlighting Library

**Decision**: Use highlight.js for code block syntax highlighting.

**Rationale**:
- Lightweight core with language plugins
- 190+ languages supported
- Integrates with marked.js
- Available via CDN with theme CSS

**CDN Source**:
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/highlight.js/styles/github.min.css">
<script src="https://cdn.jsdelivr.net/npm/highlight.js/lib/core.min.js"></script>
<!-- Add specific languages as needed -->
```

### 4. Link Security

**Decision**: Configure marked.js to add `target="_blank"` and `rel="noopener noreferrer"` to external links.

**Rationale**:
- Prevents tabnabbing attacks
- Opens external links in new tab (expected UX)
- Required by FR-003

**Implementation**:
```javascript
const renderer = new marked.Renderer();
renderer.link = function(href, title, text) {
  return `<a href="${href}" target="_blank" rel="noopener noreferrer"${title ? ` title="${title}"` : ''}>${text}</a>`;
};
```

### 5. Image Handling

**Decision**: Allow external images with max-width constraint via CSS.

**Rationale**:
- Blocking all external images would break many documents
- CSS constraint prevents layout issues
- DOMPurify can be configured to allow img tags safely

**CSS**:
```css
.markdown-content img {
  max-width: 100%;
  height: auto;
}
```

### 6. Sanitization Configuration

**Decision**: Configure DOMPurify to allow safe HTML while stripping all dangerous elements.

**Allowed**:
- Basic formatting: `em`, `strong`, `code`, `pre`, `blockquote`
- Links: `a` (with href validation)
- Images: `img` (with src validation)
- Tables: `table`, `thead`, `tbody`, `tr`, `th`, `td`
- Lists: `ul`, `ol`, `li`
- Headings: `h1`-`h6`

**Stripped**:
- `script`, `style`, `iframe`, `object`, `embed`
- Event handlers: `onclick`, `onerror`, etc.
- JavaScript URLs: `javascript:`, `data:` with scripts

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Markdown Parser | marked.js | Lightweight, GFM support, CDN |
| Sanitization | DOMPurify | Industry standard, secure |
| Syntax Highlighting | highlight.js | Lightweight, good integration |
| External Links | target="_blank" + rel | Security + UX |
| Images | Allow with max-width CSS | Usability vs security balance |
| Dangerous Elements | Strip completely | Security requirement |
