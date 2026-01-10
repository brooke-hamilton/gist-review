# Feature Specification: Fetch and Display Gist Comments

**Feature Branch**: `7-display-gist-comments`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "Fetch comments for the current Gist using the GitHub API (authenticated for private gists). Display comments in a sidebar or panel. Parse any YAML/JSON front matter from comment bodies to extract review metadata."

## Clarifications

### Session 2026-01-10

- Q: Where should the comments sidebar be positioned relative to the Gist content? → A: Right sidebar (content on left, comments on right).
- Q: In what order should comments be displayed in the sidebar? → A: Group by anchor position in document, then chronological within groups.
- Q: What delimiter format should be used to identify front matter in comment bodies? → A: Triple dashes only (`---` at start and end of front matter block).
- Q: Should the comments sidebar be collapsible to maximize content viewing area? → A: Yes, collapsible with a toggle button (default expanded).

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Comments on Public Gist (Priority: P1)

A user views a public Gist that has existing comments. The application displays the comments in a visible sidebar or panel alongside the Gist content.

**Why this priority**: Viewing existing comments is the foundation of the review experience. Users need to see feedback from others before they can participate.

**Independent Test**: Can be fully tested by loading a public Gist with comments and verifying comments appear in the sidebar without authentication.

**Acceptance Scenarios**:

1. **Given** a public Gist has comments, **When** an unauthenticated user loads the Gist, **Then** all comments are displayed in the sidebar.
2. **Given** comments are displayed, **When** the user views a comment, **Then** the comment author and timestamp are visible.
3. **Given** a Gist has no comments, **When** the user loads the Gist, **Then** the sidebar indicates there are no comments yet.

---

### User Story 2 - View Comments on Private Gist (Priority: P2)

An authenticated user views a private Gist they have access to. The application fetches and displays comments using their authenticated session.

**Why this priority**: Private Gists require authentication to access. Supporting this expands the application's usefulness to private document review.

**Independent Test**: Can be tested by logging in, loading a private Gist with comments, and verifying comments appear.

**Acceptance Scenarios**:

1. **Given** an authenticated user has access to a private Gist, **When** they load the Gist, **Then** comments are fetched and displayed.
2. **Given** an unauthenticated user tries to view a private Gist, **When** comments can't be fetched, **Then** a message prompts them to log in.

---

### User Story 3 - View Parsed Review Metadata (Priority: P2)

A user views a Gist with comments that contain review metadata in YAML or JSON front matter. The application parses this metadata and makes it available for display (e.g., showing anchoring information).

**Why this priority**: Review metadata enables contextual anchoring (future features). Parsing front matter is necessary preparation for visual anchoring.

**Independent Test**: Can be tested by loading a Gist with comments containing front matter and verifying the metadata is parsed and accessible (visible in comment details or developer console).

**Acceptance Scenarios**:

1. **Given** a comment contains YAML front matter, **When** the comment is displayed, **Then** the front matter is parsed and metadata is extracted.
2. **Given** a comment contains JSON front matter, **When** the comment is displayed, **Then** the front matter is parsed and metadata is extracted.
3. **Given** a comment has no front matter, **When** the comment is displayed, **Then** the full comment body is shown as the comment text.
4. **Given** front matter is parsed, **When** viewing the comment, **Then** the comment body (after front matter) is displayed to the user.

---

### Edge Cases

- What happens when a Gist has many comments (e.g., 100+)?
  - Comments should load and display with scrolling in the sidebar.
- What happens when front matter is malformed?
  - Treat the comment as having no front matter and display the full body.
- What happens when the comment fetch fails?
  - Display an error message and allow retry.
- What happens when comments contain Markdown?
  - Comments should be rendered as formatted Markdown (reusing the existing renderer).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST fetch comments for the currently displayed Gist
- **FR-002**: System MUST display comments in a right sidebar adjacent to the Gist content
- **FR-002a**: System MUST provide a toggle button to collapse/expand the comments sidebar
- **FR-002b**: System MUST default to expanded state for the comments sidebar
- **FR-003**: System MUST display comment author and timestamp for each comment
- **FR-003a**: System MUST order comments by anchor position in document, then chronologically within each anchor group
- **FR-003b**: System MUST display unanchored comments after anchored comments in chronological order
- **FR-004**: System MUST fetch comments for public Gists without authentication
- **FR-005**: System MUST fetch comments for private Gists using authenticated requests
- **FR-006**: System MUST parse YAML front matter from comment bodies when present
- **FR-007**: System MUST parse JSON front matter from comment bodies when present
- **FR-008**: System MUST display the comment body (excluding front matter) to users
- **FR-009**: System MUST handle malformed front matter gracefully (treat as no front matter)
- **FR-010**: System MUST indicate when a Gist has no comments
- **FR-011**: System MUST handle comment fetch errors with user-friendly messages

### Key Entities

- **Gist Comment**: A comment attached to a Gist, containing author, timestamp, body text, and optionally parsed front matter metadata.
- **Front Matter**: YAML or JSON metadata embedded at the beginning of a comment body, containing review-specific information like anchoring data.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Comments display within 3 seconds of loading a Gist
- **SC-002**: 100% of public Gist comments are viewable without authentication
- **SC-003**: Private Gist comments are accessible when authenticated with appropriate access
- **SC-004**: Front matter is correctly parsed for comments containing valid YAML or JSON
- **SC-005**: Comment sidebar remains usable and scrollable with 50+ comments

## Assumptions

- The Fetch and Display Public Gist feature (Task 3) is complete
- The GitHub OAuth Authentication feature (Task 6) is complete for private Gist access
- Comments use YAML or JSON front matter delimited by triple dashes (`---`) at the start and end of the metadata block
- The Markdown rendering feature (Task 4) can be reused for comment body formatting
- The GitHub API provides comment data including author and timestamp
