# Data Model: GitHub OAuth Authentication

**Feature**: 6-github-oauth  
**Date**: 2026-01-10

## Overview

This feature introduces authentication state management with User and Session entities stored in localStorage.

## Entities

### AuthSession

Represents the current authentication state.

| Field | Type | Description |
|-------|------|-------------|
| accessToken | string | GitHub OAuth access token |
| user | UserProfile | Authenticated user's profile |
| authenticatedAt | string | ISO timestamp of authentication |

### UserProfile

Basic user information from GitHub.

| Field | Type | Description |
|-------|------|-------------|
| login | string | GitHub username |
| id | number | GitHub user ID |
| avatar_url | string | URL to user's avatar image |
| name | string \| null | Display name (may be null) |

### DeviceCodeResponse

Response from device code request.

| Field | Type | Description |
|-------|------|-------------|
| device_code | string | Code for polling (not shown to user) |
| user_code | string | Code user enters on GitHub |
| verification_uri | string | URL user visits to authorize |
| expires_in | number | Seconds until codes expire |
| interval | number | Minimum polling interval in seconds |

## State Management

### localStorage Key

`gist_review_auth`

### Application Auth State

```javascript
// Not authenticated
{
  isAuthenticated: false,
  user: null,
  accessToken: null
}

// Authenticating (Device Flow in progress)
{
  isAuthenticated: false,
  user: null,
  accessToken: null,
  deviceFlow: {
    userCode: 'ABCD-1234',
    verificationUri: 'https://github.com/login/device',
    expiresAt: Date
  }
}

// Authenticated
{
  isAuthenticated: true,
  user: {
    login: 'username',
    avatar_url: 'https://...'
  },
  accessToken: 'gho_xxxxx'
}
```

## Functions

### initiateDeviceFlow(): Promise<DeviceCodeResponse>

Starts the Device Flow by requesting a device code.

### pollForToken(deviceCode: string, interval: number): Promise<string>

Polls GitHub for authorization completion.

### fetchUserProfile(accessToken: string): Promise<UserProfile>

Fetches the authenticated user's profile.

### saveSession(session: AuthSession): void

Persists session to localStorage.

### loadSession(): AuthSession | null

Loads session from localStorage.

### clearSession(): void

Removes session from localStorage (logout).

### isTokenValid(): boolean

Checks if stored token is likely valid (not expired locally).

### getAuthHeaders(): Headers

Returns headers with Authorization for API requests.
