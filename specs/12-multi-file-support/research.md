# Research: Multi-File Gist Support

**Feature**: 12-multi-file-support  
**Date**: 2026-01-10

## Research Tasks

### 1. Gist File Structure

**Decision**: Use GitHub Gist API `files` object which contains filename-keyed file data.

**API Response Structure**:

```json
{
  "files": {
    "readme.md": {
      "filename": "readme.md",
      "type": "text/markdown",
      "language": "Markdown",
      "raw_url": "...",
      "content": "# File content..."
    },
    "app.js": {
      "filename": "app.js",
      "type": "application/javascript",
      "language": "JavaScript",
      "content": "// Code..."
    }
  }
}
```

**Rationale**: Already fetched in Spec 3, just need to utilize all files.

### 2. Tab Bar UI Pattern

**Decision**: Horizontal scrollable tab bar using native HTML/CSS.

**HTML Structure**:

```html
<nav class="file-tabs" role="tablist">
  <button role="tab" aria-selected="true" data-file="readme.md">
    readme.md
  </button>
  <button role="tab" aria-selected="false" data-file="app.js">
    app.js
  </button>
</nav>
```

**CSS**:

```css
.file-tabs {
  display: flex;
  overflow-x: auto;
  border-bottom: 1px solid var(--border-color);
  scrollbar-width: thin;
}

.file-tabs button {
  white-space: nowrap;
  padding: 8px 16px;
  border: none;
  background: transparent;
  cursor: pointer;
}

.file-tabs button[aria-selected="true"] {
  border-bottom: 2px solid var(--accent-color);
  font-weight: 600;
}
```

### 3. URL Parameter for File Selection

**Decision**: Use `?file=` parameter with URL-encoded filename.

**Implementation**:

```javascript
function updateFileInUrl(filename) {
  const url = new URL(window.location);
  url.searchParams.set('file', filename);
  history.replaceState(null, '', url);
}

function getFileFromUrl() {
  const params = new URLSearchParams(window.location.search);
  return params.get('file');
}
```

### 4. File Sorting

**Decision**: Sort files alphabetically for consistent ordering.

```javascript
const sortedFiles = Object.keys(gist.files).sort((a, b) => 
  a.toLowerCase().localeCompare(b.toLowerCase())
);
```

### 5. Non-Markdown File Rendering

**Decision**: Detect by file extension or language field, render as syntax-highlighted code block.

**Implementation**:

```javascript
function renderFile(file) {
  if (isMarkdown(file.filename)) {
    return renderMarkdown(file.content);
  }
  const lang = file.language?.toLowerCase() || 'plaintext';
  return `<pre><code class="language-${lang}">${escapeHtml(file.content)}</code></pre>`;
}

function isMarkdown(filename) {
  return /\.(md|markdown|mdown|mkdn)$/i.test(filename);
}
```

### 6. Comment Filtering by File

**Decision**: Filter comments by `file` field in anchor metadata.

```javascript
function getCommentsForFile(comments, filename) {
  return comments.filter(c => c.anchor?.file === filename);
}
```

### 7. Many Files Handling

**Decision**: Horizontal scroll with fade indicators for 20+ files.

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| File Structure | Use `files` object from API | Already available |
| Tab Bar | Horizontal scrollable tabs | Standard UI pattern |
| URL Param | `?file=encoded_name` | Shareable URLs |
| Sorting | Alphabetical case-insensitive | Consistent order |
| Non-Markdown | highlight.js code blocks | Existing dependency |
| Filtering | By file field in anchor | Per-file comments |
| Many Files | Horizontal scroll | Usable at scale |
