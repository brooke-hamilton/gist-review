# Quickstart: Fetch and Display Public Gist

**Feature**: 3-fetch-public-gist  
**Date**: 2026-01-10

## Prerequisites

- Completed Spec 1 (Static Site Foundation)
- Completed Spec 2 (URL Parameter Routing)
- Public GitHub Gist IDs for testing

## Implementation Steps

1. **Extend app.js** with Gist fetching logic:
   - Add `fetchGist(gistId)` function using Fetch API
   - Implement 10-second timeout with AbortController
   - Parse response and extract first file content
   - Handle all error cases with specific messages

2. **Add loading state** to UI:
   - Show spinner/message while fetching
   - Replace with content when loaded
   - Show error message on failure

3. **Add retry button** for network errors

## Test Gist IDs

```
# Valid public Gist (use any real public Gist ID)
?gist=aa5a315d61ae9438b18d

# Invalid/non-existent Gist
?gist=thisdoesnotexist123456

# Full URL format
?gist=https://gist.github.com/username/aa5a315d61ae9438b18d
```

## Testing Scenarios

### Happy Path

1. Navigate to `?gist={valid_id}`
2. Verify loading indicator appears
3. Verify content displays within 3 seconds
4. Verify raw Markdown is visible

### Error Cases

1. **404 Error**: Use non-existent Gist ID
2. **Network Error**: Use browser DevTools to go offline
3. **Timeout**: Use DevTools to throttle to slow 3G
4. **Rate Limit**: Make 60+ requests in an hour (or test with mocked response)

## Verification Steps

1. Start local server: `python -m http.server 8000`
2. Test with valid public Gist ID
3. Test with invalid Gist ID (verify 404 message)
4. Test offline (verify network error message)
5. Test retry functionality

## Success Criteria Checklist

- [ ] Public Gist content displays within 3 seconds
- [ ] Error messages appear within 5 seconds when fetch fails
- [ ] Loading indicator visible during fetch
- [ ] 404 error shows "Gist not found" message
- [ ] Network error shows connection message with retry
- [ ] Timeout error after 10 seconds
