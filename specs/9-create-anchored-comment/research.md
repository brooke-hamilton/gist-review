# Research: Create Anchored Comment

**Feature**: 9-create-anchored-comment  
**Date**: 2026-01-10

## Research Tasks

### 1. Create Comment API

**Decision**: Use `POST /gists/{gist_id}/comments` endpoint.

**Rationale**:

- Official GitHub API for creating Gist comments
- Requires authentication
- Returns created comment for immediate display

**Request Body**:

```json
{
  "body": "---\nline_start: 5\n...\n---\n\nComment text here"
}
```

### 2. YAML Front Matter Serialization

**Decision**: Use js-yaml's `dump()` function with appropriate options.

**Rationale**:

- Ensures valid YAML output
- Handles special characters properly
- Consistent with parsing in Spec 7

**Configuration**:

```javascript
jsyaml.dump(metadata, {
  lineWidth: -1,  // Don't wrap long lines
  quotingType: '"',  // Use double quotes for strings
  forceQuotes: true  // Quote strings with special chars
});
```

### 3. Front Matter Schema

**Decision**: Use flat structure with specified keys per spec clarification.

**Schema**:

```yaml
---
line_start: 5
line_end: 7
offset_start: 0
offset_end: 42
selected_text: "The text that was selected"
revision: abc123def456
file: readme.md
---
```

### 4. Comment Input UI

**Decision**: Expand selection popover to include text input and submit button.

**Rationale**:

- Keeps interaction contextual
- Required by spec FR-001a
- Natural flow from selection to commenting

**UI Elements**:

- Textarea for comment text
- Preview/Edit toggle tabs
- Submit button
- Cancel button

### 5. Markdown Preview

**Decision**: Add preview tab that renders comment as Markdown.

**Rationale**:

- Required by spec FR-001b
- Reuses existing Markdown renderer
- Users can verify formatting before submission

### 6. Draft Preservation

**Decision**: Store draft in sessionStorage during authentication flow.

**Rationale**:

- Required by spec FR-011a, FR-011b
- sessionStorage clears on tab close (appropriate for drafts)
- Survives OAuth redirect

**Storage Key**: `gist_review_comment_draft`

**Structure**:

```javascript
{
  gistId: 'abc123',
  selection: { /* selection data */ },
  text: 'Draft comment text'
}
```

### 7. Validation

**Decision**: Require non-empty comment text before submission.

**Rationale**:

- Required by spec FR-012
- Show inline validation error
- Disable submit button when empty

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| API | `POST /gists/{id}/comments` | Official GitHub API |
| Serialization | js-yaml dump | Proper escaping |
| Schema | Flat YAML with 7 fields | Spec requirement |
| UI | Expanded popover | Contextual interaction |
| Preview | Tab toggle | Spec requirement |
| Drafts | sessionStorage | Survives OAuth redirect |
| Validation | Non-empty required | Spec requirement |
