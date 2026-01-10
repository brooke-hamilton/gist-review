# Quickstart: GitHub OAuth Authentication

**Feature**: 6-github-oauth  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-5
- GitHub account with OAuth App creation permissions
- GitHub OAuth App created (see Setup section)

## Setup: Create GitHub OAuth App

1. Go to GitHub Settings → Developer settings → OAuth Apps
2. Click "New OAuth App"
3. Fill in:
   - **Application name**: Gist Review (Development)
   - **Homepage URL**: `http://localhost:8000`
   - **Authorization callback URL**: `http://localhost:8000` (not used for Device Flow)
4. After creation, enable **Device Flow** in app settings
5. Copy the **Client ID** (no client secret needed for Device Flow)

## Implementation Steps

1. **Add login/logout UI to header**:

   ```html
   <div class="auth-container">
     <!-- When logged out -->
     <button id="login-btn">Sign in with GitHub</button>
     
     <!-- When logged in -->
     <div class="user-info" hidden>
       <img class="user-avatar" src="" alt="Avatar">
       <span class="username"></span>
       <button id="logout-btn">Sign out</button>
     </div>
   </div>
   ```

2. **Implement Device Flow**:
   - Request device code on login click
   - Show modal with user code and verification link
   - Poll for authorization completion
   - Store token and fetch user profile

3. **Add logout functionality**:
   - Clear localStorage
   - Update UI to logged-out state

4. **Persist authentication**:
   - Check localStorage on page load
   - Restore user session if present
   - Update UI accordingly

5. **Handle expired/revoked tokens**:
   - Catch 401 errors on API calls
   - Clear session and prompt re-login

## Configuration

Create a config object in app.js:

```javascript
const CONFIG = {
  GITHUB_CLIENT_ID: 'your_client_id_here',
  GITHUB_DEVICE_AUTH_URL: 'https://github.com/login/device/code',
  GITHUB_TOKEN_URL: 'https://github.com/login/oauth/access_token'
};
```

## Testing

### Happy Path

1. Click "Sign in with GitHub"
2. Modal appears with code (e.g., "ABCD-1234")
3. Click link to github.com/login/device
4. Enter code on GitHub
5. Authorize the app
6. Modal closes, header shows avatar + username
7. Refresh page - still logged in

### Error Cases

1. **User cancels**: Close modal before completing
2. **Code expires**: Wait 15 minutes without completing
3. **Token revoked**: Revoke token in GitHub settings, then use app

### Localhost Development

Device Flow works from localhost without special configuration.

## Success Criteria Checklist

- [ ] Login flow completes within 30 seconds
- [ ] Session persists across browser refresh
- [ ] Only `gist` scope is requested
- [ ] Logout clears authentication immediately
- [ ] Avatar and username display in header when logged in
- [ ] Device Flow works from localhost
