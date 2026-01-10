# API Contract: GitHub Gist Revision API

**Feature**: 5-gist-revision-selector  
**Date**: 2026-01-10

## Endpoint: Get a Specific Gist Revision

### Request

```http
GET https://api.github.com/gists/{gist_id}/{sha}
Accept: application/vnd.github+json
```

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| gist_id | string | Yes | The unique identifier of the Gist |
| sha | string | Yes | The revision SHA/version to retrieve |

### Response: 200 OK

Same structure as the base Gist endpoint, but reflects the Gist state at that revision:

```json
{
  "url": "https://api.github.com/gists/aa5a315d61ae9438b18d/abc123",
  "id": "aa5a315d61ae9438b18d",
  "description": "Example Gist (at this revision)",
  "public": true,
  "files": {
    "example.md": {
      "filename": "example.md",
      "type": "text/plain",
      "language": "Markdown",
      "content": "# Content at this revision..."
    }
  },
  "created_at": "2026-01-01T00:00:00Z",
  "updated_at": "2026-01-05T12:00:00Z"
}
```

### Response: 404 Not Found

Returned when either the Gist ID or the revision SHA is not found.

```json
{
  "message": "Not Found",
  "documentation_url": "https://docs.github.com/rest/gists/gists#get-a-gist-revision"
}
```

## Revision History (from base Gist endpoint)

The base `GET /gists/{gist_id}` endpoint includes history:

```json
{
  "history": [
    {
      "version": "abc123def456789...",
      "committed_at": "2026-01-10T14:30:00Z",
      "change_status": {
        "deletions": 5,
        "additions": 10,
        "total": 15
      },
      "user": {
        "login": "username",
        "id": 12345,
        "avatar_url": "https://avatars.githubusercontent.com/u/12345"
      }
    },
    {
      "version": "def456ghi789012...",
      "committed_at": "2026-01-08T10:00:00Z",
      "change_status": {
        "deletions": 0,
        "additions": 50,
        "total": 50
      },
      "user": {
        "login": "username",
        "id": 12345
      }
    }
  ]
}
```

## Usage in Application

```javascript
// Extract revisions from main Gist response
function getRevisions(gist) {
  return gist.history.map(rev => ({
    version: rev.version,
    timestamp: rev.committed_at,
    user: rev.user?.login
  }));
}

// Fetch specific revision content
async function fetchRevision(gistId, sha) {
  const response = await fetch(
    `https://api.github.com/gists/${gistId}/${sha}`,
    {
      headers: {
        'Accept': 'application/vnd.github+json'
      }
    }
  );
  
  if (!response.ok) {
    throw new Error(`Revision not found: ${sha}`);
  }
  
  return await response.json();
}
```
