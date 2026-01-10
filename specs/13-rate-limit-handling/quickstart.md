# Quickstart: Rate Limit Handling

**Feature**: 13-rate-limit-handling  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-12
- Understanding of GitHub API rate limits

## Implementation Steps

1. **Add rate limit indicator HTML**:

   ```html
   <div class="rate-limit-indicator" aria-live="polite">
     <span class="rate-remaining">--</span>/<span class="rate-limit">--</span>
     <span class="reset-time"></span>
   </div>
   ```

2. **Add rate limit CSS**:

   ```css
   .rate-limit-indicator {
     font-size: 0.75rem;
     color: var(--text-muted);
     display: flex;
     align-items: center;
     gap: 4px;
   }
   
   .rate-limit-indicator.warning {
     color: var(--warning-color);
   }
   
   .rate-limit-indicator.exhausted {
     color: var(--error-color);
   }
   
   .rate-limit-error {
     background: var(--error-bg);
     border: 1px solid var(--error-color);
     padding: 16px;
     border-radius: 8px;
     margin: 16px;
   }
   
   .rate-limit-error .auth-suggestion {
     margin-top: 12px;
   }
   
   .rate-limit-error .auth-link {
     color: var(--accent-color);
     cursor: pointer;
     text-decoration: underline;
   }
   ```

3. **Implement header parsing**:
   - Create `parseRateLimitHeaders(response)` function
   - Handle missing headers gracefully
   - Return default values if headers absent

4. **Wrap all API calls**:
   - Update existing fetch calls to use wrapper
   - Extract and store rate limit from every response
   - Update display after each call

5. **Implement display updates**:
   - Update fraction display (remaining/limit)
   - Add warning class when < 10 remaining
   - Add exhausted class when <= 0

6. **Implement error handling**:
   - Detect 403 rate limit responses
   - Parse error message to confirm rate limit
   - Show user-friendly error with countdown

7. **Implement countdown**:
   - Calculate seconds until reset
   - Format as "X minutes" or "Xh Ym"
   - Update every minute

8. **Implement auth suggestion**:
   - Check if user is authenticated
   - If not, show login link in error
   - Connect to Spec 6 OAuth flow

## Testing

### Test Scenarios

1. **Normal usage** - Indicator shows remaining/limit
2. **After request** - Counter decrements
3. **Warning threshold** - Yellow when < 10
4. **Rate limited** - Error message appears
5. **Reset countdown** - Shows time remaining
6. **Auth suggestion** - Login link for unauth users
7. **After auth** - Higher limit shown
8. **Missing headers** - Graceful fallback
9. **After reset** - Counter refreshes

### Testing Approach

Since exhausting rate limits is impractical:

1. Mock API responses with low limit headers
2. Manually test warning at real low counts
3. Verify countdown math with known timestamps

## Verification Steps

1. Load app, verify rate limit indicator visible
2. Make API request, verify counter updates
3. Verify warning styling when appropriate
4. Test error handling with mocked 403 response
5. Verify reset countdown displays correctly
6. If unauthenticated, verify login suggestion
7. Verify authenticated shows 5000 limit

## Success Criteria Checklist

- [ ] Rate limit visible in header/toolbar
- [ ] Shows fraction format (45/60)
- [ ] Updates after each API request
- [ ] Warning at < 10 remaining
- [ ] User-friendly error when exhausted
- [ ] Countdown to reset displayed
- [ ] Auth suggestion for unauth users
- [ ] Handles missing headers gracefully
