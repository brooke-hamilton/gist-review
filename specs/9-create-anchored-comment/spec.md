# Feature Specification: Create Anchored Comment

**Feature Branch**: `9-create-anchored-comment`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "Enable authenticated users to create a new Gist comment anchored to the current text selection. Embed the selection metadata (line, offsets, selected text, Gist revision) as YAML front matter in the comment body. Submit using the GitHub API."

## Clarifications

### Session 2026-01-10

- Q: Where should the comment input UI appear when the user wants to create a comment? → A: Expand selection popover to include a text input and submit button.
- Q: What should be the exact YAML front matter schema for anchored comments? → A: Flat structure with keys: `line_start`, `line_end`, `offset_start`, `offset_end`, `selected_text`, `revision`, `file`.
- Q: Should the comment draft be preserved if the user needs to re-authenticate mid-submission? → A: Yes, preserve draft in sessionStorage and restore after re-auth.
- Q: Should users be able to preview their comment as rendered Markdown before submitting? → A: Yes, provide a preview tab/toggle to see rendered Markdown.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Create Comment on Selected Text (Priority: P1)

An authenticated user selects text in the Gist and wants to leave a comment about that specific passage. They write their comment and submit it, creating a new Gist comment anchored to their selection.

**Why this priority**: Creating anchored comments is the core review functionality. This enables users to provide contextual feedback on specific parts of a document.

**Independent Test**: Can be fully tested by logging in, selecting text, entering a comment, submitting, and verifying the comment appears on the GitHub Gist page.

**Acceptance Scenarios**:

1. **Given** an authenticated user has selected text, **When** they enter a comment and click submit, **Then** a new comment is created on the Gist.
2. **Given** a comment is submitted, **When** viewing the comment on GitHub, **Then** the comment body contains the anchoring metadata as front matter.
3. **Given** the comment is created successfully, **When** the user views the comment sidebar, **Then** the new comment appears immediately.

---

### User Story 2 - Embed Selection Metadata in Comment (Priority: P1)

When a comment is created, the selection metadata (line number, offsets, selected text, and Gist revision) is embedded as YAML front matter in the comment body, preserving the anchoring information.

**Why this priority**: Embedded metadata is what enables visual anchoring and revision-specific comments in future features. Without it, comments lose their contextual connection.

**Independent Test**: Can be tested by creating a comment and inspecting the raw comment body on GitHub to verify it contains valid YAML front matter with all required fields.

**Acceptance Scenarios**:

1. **Given** a comment is created, **When** viewing the raw body on GitHub, **Then** it begins with YAML front matter delimited by `---`.
2. **Given** front matter is present, **When** examined, **Then** it contains the line number, start offset, end offset, and selected text.
3. **Given** front matter is present, **When** examined, **Then** it contains the Gist revision ID the comment was made against.

---

### User Story 3 - Prompt Login for Unauthenticated Users (Priority: P2)

An unauthenticated user selects text and attempts to create a comment. The application prompts them to log in before they can submit a comment.

**Why this priority**: Clear guidance for unauthenticated users improves the experience and directs them toward authentication without confusion.

**Independent Test**: Can be tested by selecting text while logged out and verifying a "login to comment" message or prompt appears.

**Acceptance Scenarios**:

1. **Given** an unauthenticated user selects text, **When** they attempt to comment, **Then** a prompt indicates they need to log in.
2. **Given** a login prompt is shown, **When** the user clicks to log in, **Then** the OAuth flow begins.
3. **Given** the user logs in after the prompt, **When** they return, **Then** they can proceed to create their comment.

---

### Edge Cases

- What happens when the comment submission fails (API error)?
  - Display an error message and allow the user to retry without losing their comment text.
- What happens when the user's authentication expires during comment creation?
  - Detect the auth failure, preserve the comment draft in sessionStorage, prompt re-authentication, and restore the draft after successful login.
- What happens when the selected text has special characters that might break YAML?
  - Properly escape the selected text in the YAML front matter.
- What happens when the user tries to submit an empty comment?
  - Require at least some comment text and show validation feedback.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST allow authenticated users to create comments on Gists
- **FR-001a**: System MUST display comment input (text area and submit button) in an expanded selection popover
- **FR-001b**: System MUST provide a preview tab/toggle to show comment as rendered Markdown before submission
- **FR-002**: System MUST embed selection metadata as YAML front matter in the comment body
- **FR-003**: System MUST include line number in the front matter
- **FR-004**: System MUST include selection start offset in the front matter
- **FR-005**: System MUST include selection end offset in the front matter
- **FR-006**: System MUST include the selected text in the front matter
- **FR-007**: System MUST include the Gist revision ID in the front matter
- **FR-008**: System MUST submit the comment using authenticated API requests
- **FR-009**: System MUST display the new comment in the sidebar after successful submission
- **FR-010**: System MUST prompt unauthenticated users to log in when attempting to comment
- **FR-011**: System MUST handle submission errors gracefully with user-friendly messages
- **FR-011a**: System MUST preserve comment draft in sessionStorage during re-authentication flow
- **FR-011b**: System MUST restore comment draft after successful re-authentication
- **FR-012**: System MUST validate that comment text is not empty before submission
- **FR-013**: System MUST properly escape special characters in the YAML front matter

### Key Entities

- **Anchored Comment**: A Gist comment containing YAML front matter with metadata linking it to a specific text selection and revision.
- **Comment Front Matter**: YAML metadata with fields: `line_start` (int), `line_end` (int), `offset_start` (int), `offset_end` (int), `selected_text` (string), `revision` (string), `file` (string).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Comments are successfully created and visible on GitHub within 5 seconds of submission
- **SC-002**: 100% of created comments contain valid, parseable YAML front matter
- **SC-003**: Front matter correctly reflects the selection metadata for all valid selections
- **SC-004**: Unauthenticated users see a clear login prompt within 1 second of attempting to comment
- **SC-005**: Users can recover from submission errors without re-entering their comment

## Assumptions

- The GitHub OAuth Authentication feature (Task 6) is complete and provides authenticated API access
- The Fetch and Display Gist Comments feature (Task 7) is complete for displaying new comments
- The Text Selection Capture feature (Task 8) is complete and provides selection metadata
- YAML front matter uses flat schema: `line_start`, `line_end`, `offset_start`, `offset_end`, `selected_text`, `revision`, `file`
- The GitHub Gist Comments API is available for creating comments on Gists the user has access to
