# Research: Gist Revision Selector

**Feature**: 5-gist-revision-selector  
**Date**: 2026-01-10

## Research Tasks

### 1. GitHub Gist Revision API

**Decision**: Use the existing `GET /gists/{gist_id}` endpoint which includes revision history.

**Rationale**: 
- The main Gist endpoint returns a `history` array with all revisions
- Each revision includes version ID and timestamp
- Individual revisions fetched via `GET /gists/{gist_id}/{version}`

**History Structure**:
```json
{
  "history": [
    {
      "version": "abc123def456",
      "committed_at": "2026-01-10T12:00:00Z",
      "change_status": {
        "deletions": 0,
        "additions": 10,
        "total": 10
      },
      "user": {
        "login": "username"
      }
    }
  ]
}
```

### 2. Fetching Specific Revisions

**Decision**: Use `GET /gists/{gist_id}/{sha}` to fetch content at a specific revision.

**Rationale**:
- Returns full Gist structure at that point in time
- Same response format as base Gist endpoint
- Counts toward rate limit like other requests

### 3. Dropdown UI Component

**Decision**: Use native `<select>` element for the revision selector.

**Rationale**:
- Accessible by default (keyboard, screen reader)
- No JavaScript library needed
- Handles long lists with native scrolling
- Consistent across platforms

**Alternatives Considered**:
- Custom dropdown - Rejected: Adds complexity, accessibility concerns
- List view - Rejected: Takes more screen space

### 4. Timestamp Display Format

**Decision**: Display absolute timestamps in localized format (e.g., "Jan 8, 2026 2:30 PM").

**Rationale**:
- Clear and unambiguous
- Required by spec clarifications
- Use `Intl.DateTimeFormat` for localization

**Format**:
```javascript
new Intl.DateTimeFormat('en-US', {
  month: 'short',
  day: 'numeric',
  year: 'numeric',
  hour: 'numeric',
  minute: '2-digit'
}).format(date);
```

### 5. URL State Synchronization

**Decision**: Use `?gist={id}&rev={version}` URL format with History API for navigation.

**Rationale**:
- Enables shareable revision-specific links
- Browser back/forward navigation works naturally
- Required by FR-010, FR-011, FR-012

**Implementation**:
```javascript
// Update URL when revision changes
history.pushState({rev: versionId}, '', `?gist=${gistId}&rev=${versionId}`);

// Handle popstate for back/forward
window.addEventListener('popstate', (event) => {
  loadRevision(event.state?.rev || latestRevision);
});
```

### 6. Large History Handling

**Decision**: Load all revisions in dropdown with native browser scrolling.

**Rationale**:
- Spec explicitly states: "Scrollable dropdown with all revisions loaded"
- Native `<select>` handles this efficiently
- Simpler than pagination

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Revision Data | From main Gist endpoint | Already fetched, includes history |
| Revision Content | `/gists/{id}/{sha}` endpoint | Official API for versioned content |
| UI Component | Native `<select>` | Accessible, no dependencies |
| Timestamps | Absolute, localized | Spec requirement, clear UX |
| URL State | `?rev={version}` parameter | Shareable, browser navigation |
| Large Lists | Native scroll | Spec requirement, simple |
