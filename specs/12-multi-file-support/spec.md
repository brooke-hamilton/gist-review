# Feature Specification: Multi-File Gist Support

**Feature Branch**: `12-multi-file-support`  
**Created**: January 10, 2026  
**Status**: Draft  
**Input**: User description: "Support Gists containing multiple files. Add a file selector UI to switch between files. Maintain separate comment anchoring per file. Preserve file selection in URL if possible."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View File List for Multi-File Gist (Priority: P1)

A user loads a Gist that contains multiple files. The application displays a file selector showing all files in the Gist, allowing the user to see what's available.

**Why this priority**: Users need to know a Gist has multiple files before they can navigate between them. File visibility is the foundation for multi-file support.

**Independent Test**: Can be fully tested by loading a multi-file Gist and verifying a file selector UI shows all file names.

**Acceptance Scenarios**:

1. **Given** a Gist contains multiple files, **When** the Gist is loaded, **Then** a file selector displays all file names.
2. **Given** a file selector is visible, **When** viewing the files, **Then** the currently displayed file is visually indicated.
3. **Given** a Gist contains only one file, **When** the Gist is loaded, **Then** the file selector may be hidden or show the single file.

---

### User Story 2 - Switch Between Files (Priority: P1)

A user viewing a multi-file Gist wants to review a different file. They click on a file name in the selector and the content area updates to show that file's content.

**Why this priority**: File switching is the core interaction for multi-file Gists. Without it, users can only see one file per Gist.

**Independent Test**: Can be tested by clicking different files in the selector and verifying the content area updates accordingly.

**Acceptance Scenarios**:

1. **Given** a file selector with multiple files, **When** the user clicks a different file, **Then** the content area displays that file's content.
2. **Given** the user switches files, **When** the content updates, **Then** the file selector indicates the newly selected file.
3. **Given** the user switches files, **When** viewing comments, **Then** only comments for the selected file are displayed.

---

### User Story 3 - Maintain Separate Comments Per File (Priority: P2)

A user viewing a multi-file Gist has comments on different files. The comments and highlights are specific to each file and update when switching files.

**Why this priority**: Comment anchoring must be file-specific to maintain accuracy. Comments on one file shouldn't appear on another file.

**Independent Test**: Can be tested by creating comments on different files and verifying each file shows only its own comments.

**Acceptance Scenarios**:

1. **Given** comments exist on File A and File B, **When** viewing File A, **Then** only File A's comments are displayed.
2. **Given** the user switches from File A to File B, **When** viewing File B, **Then** File B's comments and highlights are shown.
3. **Given** a comment is created on File A, **When** the comment is saved, **Then** it includes the filename in its anchor metadata.

---

### User Story 4 - Preserve File Selection in URL (Priority: P3)

A user wants to share a link to a specific file within a multi-file Gist. The URL includes a file parameter so others open the same file directly.

**Why this priority**: URL preservation enables deep linking to specific files, improving shareability and collaboration.

**Independent Test**: Can be tested by selecting a file, copying the URL, and opening it in a new tab to verify the same file is selected.

**Acceptance Scenarios**:

1. **Given** a user selects a file, **When** viewing the URL, **Then** it includes a parameter indicating the selected file.
2. **Given** a URL with a file parameter, **When** opening the URL, **Then** that specific file is displayed.
3. **Given** a URL without a file parameter, **When** opening a multi-file Gist, **Then** the first file (alphabetically) is displayed.

---

### Edge Cases

- What happens when a Gist has many files (e.g., 20+)?
  - The file selector should remain usable with scrolling or appropriate layout.
- What happens when a file in the URL parameter doesn't exist?
  - Fall back to the first file and optionally display a message.
- What happens when file names contain special characters?
  - URL encode the file name in the URL parameter.
- What happens when files are non-Markdown (e.g., JSON, code files)?
  - Display the content as-is or with appropriate syntax highlighting (future enhancement).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display a file selector for Gists with multiple files
- **FR-002**: System MUST list all file names from the Gist in the file selector
- **FR-003**: System MUST visually indicate the currently selected file
- **FR-004**: System MUST update the content area when a different file is selected
- **FR-005**: System MUST maintain separate comment anchoring per file
- **FR-006**: System MUST include filename in comment anchor metadata
- **FR-007**: System MUST filter displayed comments and highlights by the selected file
- **FR-008**: System MUST update the URL to include the selected file parameter
- **FR-009**: System MUST read the file parameter from URL and select that file on load
- **FR-010**: System MUST default to the first file (alphabetically) when no file parameter is present
- **FR-011**: System MUST handle missing file parameter gracefully (fall back to first file)

### Key Entities

- **Gist File**: An individual file within a multi-file Gist, identified by filename and containing text content.
- **File Selector**: A UI component displaying available files and allowing the user to switch between them.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: File selector displays within 1 second of loading a multi-file Gist
- **SC-002**: Switching files updates content within 500 milliseconds (for cached content)
- **SC-003**: 100% of comments are correctly associated with their respective files
- **SC-004**: URLs with file parameters correctly open the specified file
- **SC-005**: The file selector remains usable for Gists with 20+ files

## Assumptions

- The Fetch and Display Public Gist feature (Task 3) is complete and provides multi-file Gist data
- The Fetch and Display Gist Comments feature (Task 7) is complete and provides comment data
- Comment anchor metadata will be extended to include filename
- The file parameter in the URL uses a URL-safe encoding for filenames
- Gist files are ordered alphabetically by filename (matching GitHub's behavior)
