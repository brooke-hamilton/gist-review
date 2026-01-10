# Quickstart: URL Parameter Routing

**Feature**: 2-url-parameter-routing  
**Date**: 2026-01-10

## Prerequisites

- Completed Spec 1 (Static Site Foundation)
- Modern web browser with developer tools

## Implementation Steps

1. **Create/update app.js** with URL parsing logic:
   - Parse `window.location.search` using `URLSearchParams`
   - Extract `gist` parameter value
   - Detect if value is full URL or bare ID
   - Extract Gist ID from full URLs
   - Display result in main content area

2. **Link app.js in index.html** (if not already done)

## Testing URLs

```
# Bare Gist ID
http://localhost:8000/?gist=abc123

# Full GitHub URL
http://localhost:8000/?gist=https://gist.github.com/user/abc123

# Full URL with trailing slash
http://localhost:8000/?gist=https://gist.github.com/user/abc123/

# URL-encoded parameter
http://localhost:8000/?gist=https%3A%2F%2Fgist.github.com%2Fuser%2Fabc123

# Missing parameter (shows guidance)
http://localhost:8000/

# Empty parameter (shows guidance)
http://localhost:8000/?gist=

# Multiple parameters (uses first)
http://localhost:8000/?gist=first&gist=second
```

## Verification Steps

1. Start local server: `python -m http.server 8000`
2. Navigate to each test URL above
3. Verify correct Gist ID is displayed
4. Verify guidance message appears when no parameter
5. Check browser console for errors

## Success Criteria Checklist

- [ ] `?gist=abc123` displays "Gist ID: abc123" within 1 second
- [ ] Full GitHub URLs extract the correct Gist ID
- [ ] Missing/empty parameter shows guidance message
- [ ] URL-encoded characters are handled correctly
- [ ] Bookmarked URLs work correctly
