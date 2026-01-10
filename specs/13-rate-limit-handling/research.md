# Research: Rate Limit Handling

**Feature**: 13-rate-limit-handling  
**Date**: 2026-01-10

## Research Tasks

### 1. GitHub Rate Limit Headers

**Decision**: Parse standard GitHub rate limit headers from all API responses.

**Headers**:
- `X-RateLimit-Limit`: Total requests allowed per hour
- `X-RateLimit-Remaining`: Requests remaining
- `X-RateLimit-Reset`: Unix timestamp when limit resets
- `X-RateLimit-Used`: Requests used in current window

**Implementation**:
```javascript
function parseRateLimitHeaders(response) {
  return {
    limit: parseInt(response.headers.get('X-RateLimit-Limit') || '60'),
    remaining: parseInt(response.headers.get('X-RateLimit-Remaining') || '60'),
    reset: parseInt(response.headers.get('X-RateLimit-Reset') || '0'),
    used: parseInt(response.headers.get('X-RateLimit-Used') || '0')
  };
}
```

### 2. Rate Limit Display Format

**Decision**: Show as fraction "45/60" in header indicator.

**HTML**:
```html
<div class="rate-limit-indicator">
  <span class="rate-remaining">45</span>/<span class="rate-limit">60</span>
</div>
```

### 3. Countdown Display

**Decision**: Calculate time remaining and format as "X minutes" or "X hours Y minutes".

**Implementation**:
```javascript
function formatResetTime(resetTimestamp) {
  const now = Math.floor(Date.now() / 1000);
  const secondsRemaining = Math.max(0, resetTimestamp - now);
  const minutes = Math.ceil(secondsRemaining / 60);
  
  if (minutes >= 60) {
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    return `${hours}h ${mins}m`;
  }
  return `${minutes} minutes`;
}
```

### 4. Low Rate Limit Warning

**Decision**: Add warning class when remaining < 10.

**CSS**:
```css
.rate-limit-indicator.warning {
  color: var(--warning-color);
  font-weight: 600;
}

.rate-limit-indicator.exhausted {
  color: var(--error-color);
  font-weight: 600;
}
```

### 5. Rate Limit Error Handling

**Decision**: Detect 403 with rate limit message and show friendly error.

**Implementation**:
```javascript
async function handleApiResponse(response) {
  updateRateLimitDisplay(parseRateLimitHeaders(response));
  
  if (response.status === 403) {
    const body = await response.json();
    if (body.message?.includes('rate limit')) {
      showRateLimitError(parseRateLimitHeaders(response));
      return null;
    }
  }
  return response;
}
```

### 6. Authentication Suggestion

**Decision**: Show login link in error message for unauthenticated users.

**Message Template**:
```
You've exceeded the API rate limit. Resets in {time}.
[Log in with GitHub] to increase your limit from 60 to 5,000 requests per hour.
```

### 7. Missing Headers Handling

**Decision**: Default to 60/60 for unauthenticated if headers missing.

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Headers | Parse X-RateLimit-* | Standard GitHub headers |
| Display | Fraction format (45/60) | Clear and compact |
| Countdown | Minutes/hours format | User-friendly |
| Warning | Below 10 remaining | Early notification |
| Error | Friendly message + reset time | Good UX |
| Auth Suggestion | Login link in error | Help users avoid limits |
| Missing Headers | Default to 60/60 | Graceful fallback |
