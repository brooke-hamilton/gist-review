# API Contract: GitHub Gist API

**Feature**: 3-fetch-public-gist  
**Date**: 2026-01-10

## Endpoint: Get a Gist

### Request

```http
GET https://api.github.com/gists/{gist_id}
Accept: application/vnd.github+json
```

### Path Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| gist_id | string | Yes | The unique identifier of the Gist |

### Response: 200 OK

```json
{
  "url": "https://api.github.com/gists/aa5a315d61ae9438b18d",
  "id": "aa5a315d61ae9438b18d",
  "description": "Example Gist",
  "public": true,
  "owner": {
    "login": "username",
    "id": 12345,
    "avatar_url": "https://avatars.githubusercontent.com/u/12345?v=4"
  },
  "files": {
    "example.md": {
      "filename": "example.md",
      "type": "text/plain",
      "language": "Markdown",
      "raw_url": "https://gist.githubusercontent.com/...",
      "size": 1234,
      "content": "# Example\n\nThis is the file content."
    }
  },
  "history": [
    {
      "version": "abc123def456",
      "committed_at": "2026-01-10T12:00:00Z",
      "user": {
        "login": "username"
      }
    }
  ],
  "created_at": "2026-01-01T00:00:00Z",
  "updated_at": "2026-01-10T12:00:00Z"
}
```

### Response: 404 Not Found

```json
{
  "message": "Not Found",
  "documentation_url": "https://docs.github.com/rest/gists/gists#get-a-gist"
}
```

### Response: 403 Forbidden (Rate Limited)

```json
{
  "message": "API rate limit exceeded for xxx.xxx.xxx.xxx.",
  "documentation_url": "https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting"
}
```

### Rate Limit Headers

All responses include these headers:

| Header | Description |
|--------|-------------|
| X-RateLimit-Limit | Maximum requests per hour |
| X-RateLimit-Remaining | Remaining requests this hour |
| X-RateLimit-Reset | Unix timestamp when limit resets |
| X-RateLimit-Used | Requests used this hour |

### Unauthenticated Rate Limits

- **Limit**: 60 requests per hour per IP address
- **Reset**: Hourly, based on first request timestamp

### Authenticated Rate Limits

- **Limit**: 5000 requests per hour
- **Reset**: Hourly, based on first request timestamp

## Usage in Application

```javascript
async function fetchGist(gistId) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), 10000);
  
  try {
    const response = await fetch(
      `https://api.github.com/gists/${gistId}`,
      {
        headers: {
          'Accept': 'application/vnd.github+json'
        },
        signal: controller.signal
      }
    );
    
    clearTimeout(timeoutId);
    
    if (!response.ok) {
      // Handle error based on status
    }
    
    return await response.json();
  } catch (error) {
    clearTimeout(timeoutId);
    throw error;
  }
}
```
