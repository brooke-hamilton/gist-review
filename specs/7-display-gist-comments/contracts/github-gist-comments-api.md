# API Contract: GitHub Gist Comments API

**Feature**: 7-display-gist-comments  
**Date**: 2026-01-10

## Endpoint: List Gist Comments

### Request

```http
GET https://api.github.com/gists/{gist_id}/comments
Accept: application/vnd.github+json
```

### Optional: Authenticated Request

```http
GET https://api.github.com/gists/{gist_id}/comments
Accept: application/vnd.github+json
Authorization: Bearer {ACCESS_TOKEN}
```

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| gist_id | string | Yes | The unique identifier of the Gist |

### Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| per_page | number | 30 | Results per page (max 100) |
| page | number | 1 | Page number |

### Response: 200 OK

```json
[
  {
    "id": 1234567,
    "node_id": "MDExOkdpc3RDb21tZW50MTIzNDU2Nw==",
    "url": "https://api.github.com/gists/.../comments/1234567",
    "body": "---\nline_start: 5\nline_end: 7\noffset_start: 0\noffset_end: 42\nselected_text: \"example text\"\nrevision: abc123def\nfile: readme.md\n---\n\nThis is my comment about the selected text.",
    "user": {
      "login": "octocat",
      "id": 583231,
      "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4"
    },
    "created_at": "2026-01-10T14:30:00Z",
    "updated_at": "2026-01-10T14:30:00Z"
  },
  {
    "id": 1234568,
    "body": "A plain comment without front matter.",
    "user": {
      "login": "anotheruser",
      "id": 12345,
      "avatar_url": "https://avatars.githubusercontent.com/u/12345?v=4"
    },
    "created_at": "2026-01-09T10:00:00Z",
    "updated_at": "2026-01-09T10:00:00Z"
  }
]
```

### Response: 404 Not Found

Returned when the Gist doesn't exist or is private (for unauthenticated requests).

```json
{
  "message": "Not Found",
  "documentation_url": "https://docs.github.com/rest/gists/comments#list-gist-comments"
}
```

## Front Matter Schema

Comments may contain YAML or JSON front matter delimited by `---`:

```yaml
---
line_start: 5
line_end: 7
offset_start: 0
offset_end: 42
selected_text: "The selected passage"
revision: abc123def456
file: example.md
---

The actual comment content follows the front matter.
```

### Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| line_start | number | Yes | Starting line number (1-indexed) |
| line_end | number | Yes | Ending line number (1-indexed) |
| offset_start | number | Yes | Start character offset within line |
| offset_end | number | Yes | End character offset within line |
| selected_text | string | Yes | The text that was selected |
| revision | string | Yes | Gist revision ID when comment was made |
| file | string | Yes | Filename the comment applies to |

## Pagination

Use Link header for pagination:

```
Link: <https://api.github.com/gists/.../comments?page=2>; rel="next",
      <https://api.github.com/gists/.../comments?page=5>; rel="last"
```

## Usage in Application

```javascript
async function fetchComments(gistId, accessToken = null) {
  const headers = {
    'Accept': 'application/vnd.github+json'
  };
  
  if (accessToken) {
    headers['Authorization'] = `Bearer ${accessToken}`;
  }
  
  const response = await fetch(
    `https://api.github.com/gists/${gistId}/comments`,
    { headers }
  );
  
  if (!response.ok) {
    throw new Error('Failed to fetch comments');
  }
  
  return await response.json();
}
```
