# Feature Specification: URL Parameter Routing

**Feature Branch**: `2-url-parameter-routing`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "Implement client-side URL parameter parsing to extract the `gist` parameter from URLs in the format `?gist={gist_id}`. Accept both full Gist URLs (e.g., `https://gist.github.com/user/abc123`) and bare Gist IDs. Display the extracted Gist ID on the page."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Access Gist via Bare ID (Priority: P1)

A user receives a link to review a Gist in the format `?gist=abc123` where `abc123` is the Gist ID. They click the link and the application recognizes the Gist ID and displays it, confirming which Gist will be loaded.

**Why this priority**: The bare Gist ID is the simplest and most common way users will share links. This is the core functionality that enables shareable URLs.

**Independent Test**: Can be fully tested by navigating to `?gist=abc123` and verifying "abc123" appears on the page as the identified Gist ID.

**Acceptance Scenarios**:

1. **Given** a user has a bare Gist ID, **When** they navigate to `?gist=abc123`, **Then** the page displays "abc123" as the Gist ID.
2. **Given** a user navigates to the app with a Gist ID, **When** the page loads, **Then** the Gist ID is visible without any additional user action.

---

### User Story 2 - Access Gist via Full GitHub URL (Priority: P2)

A user copies a full Gist URL from GitHub (e.g., `https://gist.github.com/user/abc123`) and pastes it as the `gist` parameter. The application extracts the Gist ID from the full URL and displays it.

**Why this priority**: Users often copy URLs directly from GitHub, so accepting full URLs reduces friction. This builds on the core bare ID functionality.

**Independent Test**: Can be tested by navigating to `?gist=https://gist.github.com/user/abc123` and verifying "abc123" appears on the page.

**Acceptance Scenarios**:

1. **Given** a user has a full Gist URL, **When** they navigate to `?gist=https://gist.github.com/user/abc123`, **Then** the page displays "abc123" as the extracted Gist ID.
2. **Given** a full Gist URL with a username, **When** the URL is parsed, **Then** only the Gist ID portion is extracted and displayed.
3. **Given** a full Gist URL with a trailing slash or hash fragment, **When** the URL is parsed, **Then** the Gist ID is still correctly extracted.

---

### User Story 3 - Handle Missing or Invalid Parameter (Priority: P3)

A user navigates to the application without a `gist` parameter or with an empty value. The application displays a helpful message explaining how to use the app with a valid Gist ID or URL.

**Why this priority**: Error handling ensures users understand what went wrong and how to proceed. This is essential but secondary to the happy path functionality.

**Independent Test**: Can be tested by navigating to the app without any query parameters and verifying a helpful message appears.

**Acceptance Scenarios**:

1. **Given** a user navigates to the app, **When** no `gist` parameter is present in the URL, **Then** the page displays a message like "Please provide a Gist ID or URL using ?gist=..."
2. **Given** a user navigates with an empty parameter, **When** the URL is `?gist=` (empty value), **Then** the page displays the same helpful message.
3. **Given** a helpful message is shown, **When** the user reads it, **Then** they understand they need to add a Gist ID to the URL.

---

### Edge Cases

- What happens when the URL contains multiple `gist` parameters?
  - The first `gist` parameter value should be used.
- What happens when the Gist URL format is from a GitHub Enterprise instance?
  - The application should extract the last path segment as the Gist ID (same logic as public GitHub).
- What happens when the URL contains URL-encoded characters?
  - The application should properly decode the parameter value before parsing.
- What happens when the Gist ID contains unusual characters?
  - GitHub Gist IDs are alphanumeric; display the extracted value as-is and let subsequent features validate it.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST parse the `gist` query parameter from the current page URL
- **FR-002**: System MUST accept bare Gist IDs (alphanumeric strings) as valid input
- **FR-003**: System MUST accept full GitHub Gist URLs and extract the Gist ID from the path
- **FR-004**: System MUST display the extracted Gist ID prominently in the main content area
- **FR-005**: System MUST display a helpful message when no `gist` parameter is provided
- **FR-006**: System MUST display a helpful message when the `gist` parameter is empty
- **FR-007**: System MUST handle URL-encoded characters in the parameter value
- **FR-008**: System MUST use only the first `gist` parameter if multiple are provided

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Navigating to `?gist=abc123` displays "abc123" within 1 second of page load
- **SC-002**: Navigating to `?gist=https://gist.github.com/user/abc123` displays "abc123" within 1 second
- **SC-003**: Navigating without a `gist` parameter displays a guidance message within 1 second
- **SC-004**: 100% of valid Gist URLs from github.com are correctly parsed to extract the Gist ID
- **SC-005**: Users can bookmark URLs with `gist` parameters and return to the same state

## Assumptions

- Gist IDs from GitHub are alphanumeric strings (hexadecimal format)
- The application runs in a browser environment with standard URL parsing capabilities
- Full Gist URLs follow the pattern `https://gist.github.com/{username}/{gist_id}` or similar variants
- The static site foundation (Task 1) is complete and provides the page structure for displaying content
