# API Contract: GitHub Device Flow

**Feature**: 6-github-oauth  
**Date**: 2026-01-10

## Step 1: Request Device Code

### Request

```http
POST https://github.com/login/device/code
Content-Type: application/x-www-form-urlencoded
Accept: application/json

client_id={CLIENT_ID}&scope=gist
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| client_id | string | Yes | OAuth App client ID |
| scope | string | Yes | Requested OAuth scope (use `gist`) |

### Response: 200 OK

```json
{
  "device_code": "3584d83530557fdd1f46af8289938c8ef79f9dc5",
  "user_code": "WDJB-MJHT",
  "verification_uri": "https://github.com/login/device",
  "expires_in": 899,
  "interval": 5
}
```

| Field | Description |
|-------|-------------|
| device_code | Code for polling (keep secret from user) |
| user_code | Code user enters on GitHub (show to user) |
| verification_uri | URL user visits to enter code |
| expires_in | Seconds until codes expire |
| interval | Minimum seconds between poll requests |

## Step 2: User Authorization

Direct user to `verification_uri` where they:

1. Log in to GitHub (if not already)
2. Enter the `user_code`
3. Authorize the application

## Step 3: Poll for Access Token

### Request

```http
POST https://github.com/login/oauth/access_token
Content-Type: application/x-www-form-urlencoded
Accept: application/json

client_id={CLIENT_ID}&device_code={DEVICE_CODE}&grant_type=urn:ietf:params:oauth:grant-type:device_code
```

### Response: Authorization Pending

```json
{
  "error": "authorization_pending",
  "error_description": "The authorization request is still pending."
}
```

**Action**: Continue polling at specified interval.

### Response: Slow Down

```json
{
  "error": "slow_down",
  "error_description": "You are polling too frequently.",
  "interval": 10
}
```

**Action**: Increase polling interval by 5 seconds.

### Response: Expired Token

```json
{
  "error": "expired_token",
  "error_description": "The device_code has expired."
}
```

**Action**: Restart flow from Step 1.

### Response: Access Denied

```json
{
  "error": "access_denied",
  "error_description": "The user has denied the authorization request."
}
```

**Action**: Show error to user, allow retry.

### Response: Success

```json
{
  "access_token": "gho_123456789abcdef123456789abcdef123456",
  "token_type": "bearer",
  "scope": "gist"
}
```

## Step 4: Get User Profile

### Request

```http
GET https://api.github.com/user
Authorization: Bearer {ACCESS_TOKEN}
Accept: application/vnd.github+json
```

### Response: 200 OK

```json
{
  "login": "octocat",
  "id": 583231,
  "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4",
  "name": "The Octocat"
}
```

## Usage in Application

```javascript
async function startDeviceFlow() {
  // Step 1: Get device code
  const codeResponse = await fetch('https://github.com/login/device/code', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    },
    body: `client_id=${CLIENT_ID}&scope=gist`
  });
  
  const { device_code, user_code, verification_uri, interval } = await codeResponse.json();
  
  // Show user_code and verification_uri to user
  showDeviceModal(user_code, verification_uri);
  
  // Step 3: Poll for token
  const token = await pollForToken(device_code, interval);
  
  // Step 4: Get user profile
  const user = await fetchUserProfile(token);
  
  return { token, user };
}
```
