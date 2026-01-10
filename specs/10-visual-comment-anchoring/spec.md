# Feature Specification: Visual Comment Anchoring

**Feature Branch**: `10-visual-comment-anchoring`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "Highlight text regions in the rendered Markdown that have associated comments. Filter displayed highlights to show only comments matching the currently selected Gist revision. Clicking a highlight should scroll to/focus the related comment."

## Clarifications

### Session 2026-01-10

- Q: What visual style should be used for text highlights? → A: Semi-transparent background color (e.g., yellow/amber).
- Q: When clicking overlapping highlights with multiple comments, how should they be presented? → A: Show a small popup/menu listing all comments, user clicks to focus one.
- Q: How should orphaned comments (anchored text no longer exists) be displayed in the sidebar? → A: Show with a visual indicator (e.g., warning icon, muted style) and tooltip explaining the anchor is outdated.
- Q: Should there be a hover state on highlights before clicking? → A: Yes, subtle hover effect (e.g., darker background, cursor change) to indicate interactivity.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - See Highlighted Text with Comments (Priority: P1)

A user views a Gist that has anchored comments. The text regions that have comments are visually highlighted in the rendered content, making it easy to see where feedback has been provided.

**Why this priority**: Visual highlights transform the review experience from scanning comments to seeing feedback in context. This is the core value of contextual anchoring.

**Independent Test**: Can be fully tested by loading a Gist with anchored comments and verifying the associated text regions are highlighted.

**Acceptance Scenarios**:

1. **Given** a Gist has anchored comments, **When** the content is displayed, **Then** the text regions referenced by comments are visually highlighted.
2. **Given** multiple comments anchor to different regions, **When** viewing the content, **Then** each region has its own highlight.
3. **Given** a Gist has no anchored comments, **When** the content is displayed, **Then** no highlights appear.

---

### User Story 2 - Filter Highlights by Revision (Priority: P1)

A user switches between Gist revisions using the revision selector. The highlights update to show only comments that were made against the currently displayed revision.

**Why this priority**: Comments are tied to specific revisions. Showing irrelevant highlights from other revisions would be confusing and potentially misleading.

**Independent Test**: Can be tested by loading a Gist with comments on different revisions, switching revisions, and verifying highlights update accordingly.

**Acceptance Scenarios**:

1. **Given** comments exist for revision A and revision B, **When** viewing revision A, **Then** only comments for revision A are highlighted.
2. **Given** the user switches from revision A to revision B, **When** the content updates, **Then** highlights update to show only revision B comments.
3. **Given** a revision has no comments, **When** viewing that revision, **Then** no highlights are displayed.

---

### User Story 3 - Click Highlight to Focus Comment (Priority: P2)

A user sees a highlighted region and wants to read the associated comment. They click the highlight and the corresponding comment in the sidebar is scrolled into view and focused.

**Why this priority**: Connecting highlights to comments completes the contextual anchoring experience. Users need a quick way to see the feedback for a specific highlight.

**Independent Test**: Can be tested by clicking a highlight and verifying the associated comment scrolls into view in the sidebar.

**Acceptance Scenarios**:

1. **Given** a highlighted region, **When** the user clicks on it, **Then** the sidebar scrolls to show the associated comment.
2. **Given** a comment is focused, **When** viewing the sidebar, **Then** the focused comment is visually distinct (highlighted, outlined, etc.).
3. **Given** multiple comments anchor to overlapping regions, **When** the user clicks the overlap, **Then** all associated comments are shown or selectable.

---

### Edge Cases

- What happens when a comment's anchored text no longer exists in the current revision?
  - No highlight appears; the comment displays in the sidebar with a warning icon, muted style, and tooltip explaining the anchor is outdated.
- What happens when multiple comments anchor to the exact same text selection?
  - A single highlight appears; clicking it shows a popup menu listing all associated comments for the user to select.
- What happens when anchored text spans multiple elements (e.g., across paragraphs)?
  - The highlight should span the full selection, even across element boundaries.
- What happens when the highlighted text is very small (1-2 characters)?
  - The highlight should still be visible and clickable.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST visually highlight text regions using semi-transparent background color (e.g., yellow/amber)
- **FR-001a**: System MUST show a subtle hover effect on highlights (darker background, pointer cursor) to indicate interactivity
- **FR-002**: System MUST use comment front matter metadata to determine highlight positions
- **FR-003**: System MUST filter highlights to show only comments matching the current revision
- **FR-004**: System MUST update highlights when the user switches revisions
- **FR-005**: System MUST allow users to click on highlights
- **FR-006**: System MUST scroll to and focus the associated comment when a highlight is clicked
- **FR-007**: System MUST show a popup menu listing all comments when clicking overlapping anchors, allowing user to select one to focus
- **FR-008**: System MUST display orphaned comments (anchor text no longer exists) with a warning indicator and explanatory tooltip in the sidebar
- **FR-009**: System MUST visually distinguish the focused comment in the sidebar
- **FR-010**: System MUST render highlights that span multiple elements correctly

### Key Entities

- **Text Highlight**: A visual indicator in the rendered content marking text that has associated comments.
- **Comment Focus**: The state where a specific comment is scrolled into view and visually emphasized in the sidebar.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Highlights render within 1 second of content display
- **SC-002**: 100% of comments for the current revision have corresponding highlights (when text exists)
- **SC-003**: Clicking a highlight focuses the comment within 500 milliseconds
- **SC-004**: Switching revisions updates highlights within 1 second
- **SC-005**: Users can visually identify all commented regions at a glance

## Assumptions

- The Gist Revision Selector feature (Task 5) is complete and provides revision switching
- The Fetch and Display Gist Comments feature (Task 7) is complete and provides parsed comment metadata
- The Text Selection Capture feature (Task 8) provides understanding of line/offset mapping
- Comment front matter contains line, offset, and revision data needed for positioning highlights
- Highlights use semi-transparent yellow/amber background color with hover state for interactivity
