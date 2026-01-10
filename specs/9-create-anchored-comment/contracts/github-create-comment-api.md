# API Contract: GitHub Create Gist Comment API

**Feature**: 9-create-anchored-comment  
**Date**: 2026-01-10

## Endpoint: Create a Gist Comment

### Request

```http
POST https://api.github.com/gists/{gist_id}/comments
Accept: application/vnd.github+json
Authorization: Bearer {ACCESS_TOKEN}
Content-Type: application/json

{
  "body": "---\nline_start: 5\nline_end: 7\noffset_start: 0\noffset_end: 42\nselected_text: \"example text\"\nrevision: abc123def\nfile: readme.md\n---\n\nThis is my comment about the selected text."
}
```

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| gist_id | string | Yes | The unique identifier of the Gist |

### Request Body

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| body | string | Yes | The comment body (including YAML front matter) |

### Response: 201 Created

```json
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
}
```

### Response: 401 Unauthorized

```json
{
  "message": "Requires authentication",
  "documentation_url": "https://docs.github.com/rest/gists/comments#create-a-gist-comment"
}
```

### Response: 404 Not Found

Returned when the Gist doesn't exist or user doesn't have access.

```json
{
  "message": "Not Found",
  "documentation_url": "https://docs.github.com/rest/gists/comments#create-a-gist-comment"
}
```

### Response: 422 Unprocessable Entity

```json
{
  "message": "Validation Failed",
  "errors": [
    {
      "resource": "GistComment",
      "field": "body",
      "code": "missing_field"
    }
  ]
}
```

## Usage in Application

```javascript
async function createComment(gistId, body, accessToken) {
  const response = await fetch(
    `https://api.github.com/gists/${gistId}/comments`,
    {
      method: 'POST',
      headers: {
        'Accept': 'application/vnd.github+json',
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ body })
    }
  );
  
  if (response.status === 401) {
    throw new Error('Authentication required');
  }
  
  if (!response.ok) {
    throw new Error('Failed to create comment');
  }
  
  return await response.json();
}
```

## Building Comment Body

```javascript
function buildCommentBody(selection, revision, file, commentText) {
  const metadata = {
    line_start: selection.lineStart,
    line_end: selection.lineEnd,
    offset_start: selection.offsetStart,
    offset_end: selection.offsetEnd,
    selected_text: selection.text,
    revision: revision,
    file: file
  };
  
  const frontMatter = jsyaml.dump(metadata, {
    lineWidth: -1,
    forceQuotes: false
  });
  
  return `---\n${frontMatter}---\n\n${commentText}`;
}
```
