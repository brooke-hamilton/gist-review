# Feature Specification: GitHub OAuth Authentication

**Feature Branch**: `6-github-oauth`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "Implement GitHub OAuth authentication using the Device Flow (or a minimal OAuth proxy). Request only the `gist` scope. Store the access token in localStorage. Show login/logout state in the UI header. Document any localhost-specific OAuth configuration needed for local development."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Log In with GitHub (Priority: P1)

A user wants to authenticate with their GitHub account to access private Gists or create comments. They click a login button and complete the GitHub OAuth flow.

**Why this priority**: Authentication is required for creating comments and accessing private Gists. This is the gateway to all authenticated functionality.

**Independent Test**: Can be fully tested by clicking login, completing GitHub OAuth, and verifying the UI shows the logged-in state.

**Acceptance Scenarios**:

1. **Given** a user is not authenticated, **When** they click the login button, **Then** the GitHub OAuth flow begins.
2. **Given** the user completes GitHub authentication, **When** redirected back to the app, **Then** the app displays their logged-in state in the header.
3. **Given** the user authorizes the app, **When** the OAuth flow completes, **Then** only the `gist` scope is requested (no access to repositories or other data).

---

### User Story 2 - Persist Login State (Priority: P2)

A logged-in user closes their browser and returns later. Their authentication is preserved and they remain logged in without needing to authenticate again.

**Why this priority**: Session persistence improves user experience by avoiding repeated login prompts. This is expected behavior for modern web applications.

**Independent Test**: Can be tested by logging in, closing the browser, reopening the app, and verifying the logged-in state is retained.

**Acceptance Scenarios**:

1. **Given** a user has logged in, **When** they refresh the page, **Then** they remain logged in.
2. **Given** a user has logged in, **When** they close and reopen the browser, **Then** they remain logged in.
3. **Given** a user's session is persisted, **When** they view the header, **Then** their logged-in state is displayed.

---

### User Story 3 - Log Out (Priority: P2)

A logged-in user wants to log out of the application. They click a logout button and their authentication is cleared.

**Why this priority**: Users must be able to end their session, especially on shared computers. This is a basic security control.

**Independent Test**: Can be tested by clicking logout while logged in and verifying the UI shows the logged-out state.

**Acceptance Scenarios**:

1. **Given** a user is logged in, **When** they click the logout button, **Then** they are logged out.
2. **Given** a user has logged out, **When** they view the header, **Then** the login button is visible instead of their account info.
3. **Given** a user has logged out, **When** they refresh the page, **Then** they remain logged out.

---

### User Story 4 - Local Development OAuth (Priority: P3)

A developer testing the application locally needs to complete the OAuth flow from localhost. The OAuth configuration supports localhost redirect URLs for development purposes.

**Why this priority**: Developers must be able to test authentication locally. This supports the development workflow without requiring deployment.

**Independent Test**: Can be tested by running the app locally, initiating OAuth, and verifying the flow completes successfully with a localhost redirect.

**Acceptance Scenarios**:

1. **Given** the app is running locally, **When** the developer initiates OAuth, **Then** the flow works with localhost as the redirect URI.
2. **Given** OAuth is configured for localhost, **When** authentication completes, **Then** the developer is redirected back to the local app.
3. **Given** localhost OAuth is needed, **When** the developer reads the documentation, **Then** they find clear setup instructions.

---

### Edge Cases

- What happens when the OAuth flow is cancelled by the user?
  - The user remains logged out and can try again.
- What happens when the stored token expires or is revoked?
  - The app should detect authentication failures and prompt re-authentication.
- What happens when OAuth is initiated from a private browsing window?
  - The flow should work but the session won't persist after closing the window.
- What happens when multiple tabs are open and the user logs in/out in one?
  - Other tabs should detect the state change on next interaction or page focus.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a login button for unauthenticated users
- **FR-002**: System MUST initiate GitHub OAuth when the login button is clicked
- **FR-003**: System MUST request only the `gist` scope during OAuth authorization
- **FR-004**: System MUST store the access token securely in browser storage
- **FR-005**: System MUST display the user's authenticated state in the UI header
- **FR-006**: System MUST persist authentication across page refreshes
- **FR-007**: System MUST persist authentication across browser sessions
- **FR-008**: System MUST provide a logout button for authenticated users
- **FR-009**: System MUST clear stored authentication when the user logs out
- **FR-010**: System MUST support OAuth flow from localhost for local development
- **FR-011**: System MUST handle OAuth flow cancellation gracefully
- **FR-012**: System MUST detect and handle expired or revoked tokens

### Key Entities

- **User Session**: The authenticated state containing the user's GitHub access token and profile information.
- **Access Token**: The OAuth token with `gist` scope that authorizes API requests on behalf of the user.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can complete login flow within 30 seconds
- **SC-002**: Login state persists across browser sessions with no re-authentication required
- **SC-003**: Only `gist` scope is requested (verifiable in GitHub OAuth consent screen)
- **SC-004**: Logout clears authentication immediately with no residual session
- **SC-005**: Developers can complete OAuth flow from localhost without manual token generation

## Assumptions

- GitHub OAuth Device Flow or a minimal proxy service will handle token exchange
- Browser localStorage is available and sufficient for token storage
- The Static Site Foundation (Task 1) provides the header UI structure for login/logout display
- GitHub's OAuth consent screen will show the requested scope to users
- Localhost redirect URIs are configured in the GitHub OAuth application settings
