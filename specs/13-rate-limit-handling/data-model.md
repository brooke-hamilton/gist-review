# Data Model: Rate Limit Handling

**Feature**: 13-rate-limit-handling  
**Date**: 2026-01-10

## Overview

This feature tracks GitHub API rate limit status and provides user feedback.

## Entities

### RateLimitStatus

Current API rate limit state.

| Field | Type | Description |
|-------|------|-------------|
| limit | number | Total requests per hour |
| remaining | number | Requests remaining |
| reset | number | Unix timestamp for reset |
| used | number | Requests used this window |
| isAuthenticated | boolean | Whether user is authenticated |

### RateLimitDisplayState

UI state for rate limit indicator.

| Field | Type | Description |
|-------|------|-------------|
| status | RateLimitStatus | Current rate limit info |
| isWarning | boolean | Below warning threshold |
| isExhausted | boolean | Limit reached |
| resetCountdown | string | Formatted reset time |

## State Management

### Extended Application State

```javascript
{
  // ... existing state
  rateLimit: {
    limit: 60,
    remaining: 45,
    reset: 1704931200,
    used: 15,
    isAuthenticated: false
  }
}
```

## Functions

### parseRateLimitHeaders(response: Response): RateLimitStatus

Extracts rate limit info from API response headers.

### updateRateLimitDisplay(status: RateLimitStatus): void

Updates the UI indicator with current status.

### formatResetTime(resetTimestamp: number): string

Formats reset time as human-readable countdown.

### showRateLimitError(status: RateLimitStatus): void

Displays rate limit error modal/banner.

### isRateLimitWarning(remaining: number): boolean

Returns true if remaining < 10.

### isRateLimitExhausted(remaining: number): boolean

Returns true if remaining <= 0.

### showAuthSuggestion(): void

Displays login suggestion for unauthenticated users.

### wrapApiCall(fetchPromise: Promise): Promise

Wrapper that parses rate limit headers from all API calls.

### startResetCountdown(resetTimestamp: number): void

Starts interval to update countdown display.

### handleRateLimitRecovery(): void

Updates UI when rate limit has reset.
