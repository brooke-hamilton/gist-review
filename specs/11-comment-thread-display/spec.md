# Feature Specification: Comment Thread Display

**Feature Branch**: `11-comment-thread-display`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "When a text highlight is clicked, show the associated comment(s) in a focused view. If multiple comments anchor to the same or overlapping selections, group them visually as a thread."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Comment Detail on Highlight Click (Priority: P1)

A user clicks on a highlighted text region and sees the associated comment displayed in a focused view, making it easy to read the full comment content.

**Why this priority**: This completes the highlight-to-comment navigation flow. Users need to read full comment content after identifying areas with feedback.

**Independent Test**: Can be fully tested by clicking a highlight and verifying the comment detail appears in a focused view.

**Acceptance Scenarios**:

1. **Given** a text highlight, **When** the user clicks it, **Then** the associated comment opens in a detailed view.
2. **Given** a comment is opened, **When** viewing the detail, **Then** the comment author is displayed.
3. **Given** a comment is opened, **When** viewing the detail, **Then** the comment timestamp is displayed.

---

### User Story 2 - View Grouped Comments as Thread (Priority: P1)

A user clicks on a highlight where multiple comments anchor to the same or overlapping text selection. The comments are displayed together as a thread, showing all feedback for that region.

**Why this priority**: Overlapping comments are common in active reviews. Grouping them prevents users from missing feedback and shows the conversation flow.

**Independent Test**: Can be tested by clicking a highlight with multiple overlapping comments and verifying all are shown as a thread.

**Acceptance Scenarios**:

1. **Given** multiple comments anchor to the same text, **When** the user clicks the highlight, **Then** all comments are displayed together as a thread.
2. **Given** comments have overlapping (but not identical) selections, **When** clicking the overlap region, **Then** all overlapping comments are shown.
3. **Given** a thread is displayed, **When** viewing the comments, **Then** they are ordered by timestamp (oldest first).

---

### User Story 3 - View Comment Author and Timestamp (Priority: P2)

When viewing a comment in a thread or detail view, the user can see who made the comment and when it was made, providing context for the feedback.

**Why this priority**: Author and timestamp are essential metadata for understanding feedback context, especially in collaborative reviews.

**Independent Test**: Can be tested by opening any comment and verifying author name/avatar and timestamp are visible.

**Acceptance Scenarios**:

1. **Given** a comment is displayed, **When** the user views it, **Then** the author's name or username is visible.
2. **Given** a comment is displayed, **When** the user views it, **Then** the timestamp shows when the comment was made.
3. **Given** a thread with multiple authors, **When** viewing the thread, **Then** each comment shows its own author.

---

### Edge Cases

- What happens when a comment author's account has been deleted?
  - Display a placeholder like "Unknown User" or the stored username.
- What happens when there are many comments in a thread (e.g., 10+)?
  - The thread should be scrollable and remain usable.
- What happens when the user clicks outside the focused comment view?
  - The focused view should close and return to the normal content view.
- What happens when overlapping comments are from different revisions but the text still exists?
  - Only show comments for the currently selected revision.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display comment detail when a highlight is clicked
- **FR-002**: System MUST display comment author in the detail view
- **FR-003**: System MUST display comment timestamp in the detail view
- **FR-004**: System MUST group multiple comments as a thread when they anchor to the same text
- **FR-005**: System MUST group comments with overlapping anchor selections as a thread
- **FR-006**: System MUST order thread comments by timestamp (oldest first)
- **FR-007**: System MUST allow the user to close the focused view and return to normal content view
- **FR-008**: System MUST handle large threads with scrolling
- **FR-009**: System MUST display the comment body content (rendered as Markdown if applicable)
- **FR-010**: System MUST only show comments from the currently selected revision

### Key Entities

- **Comment Thread**: A collection of comments anchored to the same or overlapping text selection, displayed together as a conversation.
- **Focused View**: A UI mode that emphasizes specific content (the selected comment or thread) while de-emphasizing other elements.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Clicking a highlight opens the focused view within 500 milliseconds
- **SC-002**: 100% of overlapping comments are correctly grouped into threads
- **SC-003**: Comment author and timestamp are visible for all displayed comments
- **SC-004**: Threads with 10+ comments remain scrollable and usable
- **SC-005**: Users can close the focused view and return to content within 1 interaction (click or keypress)

## Assumptions

- The Visual Comment Anchoring feature (Task 10) is complete and provides highlight clicking
- Comment metadata includes author and timestamp from the GitHub API
- The Markdown rendering feature (Task 4) can be reused for rendering comment body content
- Overlapping selections are detected by comparing line and offset ranges
- The focused view is a modal, popover, or expanded sidebar section (specific design is an implementation detail)
