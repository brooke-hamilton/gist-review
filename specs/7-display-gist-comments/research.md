# Research: Fetch and Display Gist Comments

**Feature**: 7-display-gist-comments  
**Date**: 2026-01-10

## Research Tasks

### 1. GitHub Gist Comments API

**Decision**: Use `GET /gists/{gist_id}/comments` endpoint.

**Rationale**: 
- Official GitHub API for Gist comments
- Returns all comments with author and timestamp
- Works without authentication for public Gists
- Paginated (30 per page by default)

**API Response**:
```json
[
  {
    "id": 1234567,
    "body": "---\nline_start: 5\n---\nActual comment text",
    "user": {
      "login": "username",
      "avatar_url": "https://..."
    },
    "created_at": "2026-01-10T12:00:00Z",
    "updated_at": "2026-01-10T12:00:00Z"
  }
]
```

### 2. Front Matter Parsing

**Decision**: Use triple-dash delimiters (`---`) for front matter, parse as YAML first, fall back to JSON.

**Rationale**:
- Triple-dash is YAML standard for document markers
- Required by spec clarifications
- YAML is more human-readable than JSON
- JSON fallback for flexibility

**Parsing Logic**:
```javascript
function parseFrontMatter(body) {
  const frontMatterRegex = /^---\n([\s\S]*?)\n---\n?([\s\S]*)$/;
  const match = body.match(frontMatterRegex);
  
  if (!match) return { metadata: null, content: body };
  
  try {
    const metadata = jsyaml.load(match[1]);
    return { metadata, content: match[2] };
  } catch {
    try {
      const metadata = JSON.parse(match[1]);
      return { metadata, content: match[2] };
    } catch {
      return { metadata: null, content: body };
    }
  }
}
```

### 3. YAML Parsing Library

**Decision**: Use js-yaml library via CDN.

**Rationale**:
- Lightweight, well-maintained
- Full YAML 1.1/1.2 support
- No build step required

**CDN**:
```html
<script src="https://cdn.jsdelivr.net/npm/js-yaml/dist/js-yaml.min.js"></script>
```

### 4. Sidebar Layout

**Decision**: Right sidebar (20-30% width) with content on left (70-80%).

**Rationale**:
- Right placement is conventional for comments/annotations
- Content remains primary focus
- Required by spec clarifications

**CSS Layout**:
```css
.layout {
  display: flex;
}
.content-area {
  flex: 1;
  min-width: 0;
}
.comment-sidebar {
  width: 300px;
  flex-shrink: 0;
}
```

### 5. Comment Ordering

**Decision**: Group by anchor position (line number), then chronological within groups. Unanchored comments appear last.

**Rationale**:
- Follows document flow for anchored comments
- Required by spec FR-003a, FR-003b
- Chronological within group shows conversation order

### 6. Sidebar Collapse

**Decision**: Toggle button in sidebar header to collapse/expand.

**Rationale**:
- Required by spec FR-002a
- Maximizes content area when needed
- Default to expanded (FR-002b)

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Comments API | `/gists/{id}/comments` | Official GitHub API |
| Front Matter | Triple-dash YAML/JSON | Spec requirement |
| YAML Parser | js-yaml via CDN | Lightweight, no build |
| Layout | Right sidebar, flexbox | Convention, spec requirement |
| Ordering | By anchor, then time | Document flow |
| Collapse | Toggle button | Space management |
