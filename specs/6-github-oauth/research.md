# Research: GitHub OAuth Authentication

**Feature**: 6-github-oauth  
**Date**: 2026-01-10

## Research Tasks

### 1. OAuth Flow Selection

**Decision**: Use GitHub Device Flow (OAuth 2.0 Device Authorization Grant).

**Rationale**: 
- No backend/proxy required
- Works from any origin (localhost, GitHub Pages)
- User authenticates on GitHub directly
- Simpler than managing redirect URIs

**Flow Overview**:
1. App requests device code from GitHub
2. User visits `github.com/login/device` and enters code
3. App polls for authorization completion
4. Upon approval, app receives access token

**Alternatives Considered**:
- Web Application Flow - Requires backend for token exchange
- GitHub App installation - More complex, not needed for this use case

### 2. Device Flow API Endpoints

**Decision**: Use GitHub's Device Flow endpoints:

| Step | Endpoint |
|------|----------|
| Request device code | `POST https://github.com/login/device/code` |
| Poll for token | `POST https://github.com/login/oauth/access_token` |
| Get user info | `GET https://api.github.com/user` |

### 3. OAuth App Configuration

**Decision**: Create a GitHub OAuth App (not GitHub App) with Device Flow enabled.

**Required Settings**:
- Enable Device Flow in app settings
- No callback URL needed for Device Flow
- Client ID exposed to frontend (no client secret in Device Flow)

### 4. Token Storage

**Decision**: Store access token in localStorage with user profile.

**Storage Key**: `gist_review_auth`

**Structure**:
```javascript
{
  accessToken: 'gho_xxxxx',
  user: {
    login: 'username',
    avatar_url: 'https://...',
    id: 12345
  },
  expiresAt: null  // GitHub tokens don't expire by default
}
```

**Rationale**:
- localStorage persists across sessions
- Same-origin protection
- Easy to clear on logout

### 5. Polling Strategy

**Decision**: Poll every 5 seconds (GitHub's minimum interval) with exponential backoff on slow_down.

**Rationale**:
- GitHub returns `interval` in device code response (usually 5s)
- Must respect `slow_down` error by adding 5s to interval
- `authorization_pending` is expected; keep polling
- `expired_token` means user didn't complete in time

### 6. User Profile Display

**Decision**: Display avatar image (40px circle) and username in header.

**Rationale**:
- Visual confirmation of logged-in state
- Avatar is recognizable at a glance
- Username provides explicit identity

### 7. Token Expiration Handling

**Decision**: Detect 401 responses and prompt re-authentication.

**Rationale**:
- GitHub personal access tokens don't expire by default
- But tokens can be revoked by user
- Detect via API response, not local expiry check

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| OAuth Flow | Device Flow | No backend needed |
| Storage | localStorage | Persists, same-origin protected |
| Scope | `gist` only | Minimum required |
| Polling | 5s interval, backoff | GitHub requirements |
| UI | Avatar + username | Clear visual identity |
| Expiry | Detect 401 on API calls | Handles revocation |
