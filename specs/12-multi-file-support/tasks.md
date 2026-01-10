# Tasks: Multi-File Gist Support

**Input**: Design documents from `/specs/12-multi-file-support/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: Tests are OPTIONAL - not explicitly requested in this feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: Files at repository root (`/`)
- Structure: `index.html`, `styles.css`, `app.js`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Verify Spec 3 (Fetch Public Gist) provides multi-file Gist data
- [ ] T002 Verify Spec 7 (Display Comments) is complete for comment filtering

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create horizontal tab bar element above content area in /index.html
- [ ] T004 [P] Add tab bar styles (horizontal tabs, active indicator) in /styles.css
- [ ] T005 Create file state management object (currentFile, files array) in /app.js
- [ ] T006 Create renderFileSelector() function skeleton in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View File List for Multi-File Gist (Priority: P1) 🎯 MVP

**Goal**: User loads a multi-file Gist and sees a file selector showing all files

**Independent Test**: Load a multi-file Gist and verify a file selector UI shows all file names.

### Implementation for User Story 1

- [ ] T007 [US1] Extract file list from Gist API response in /app.js
- [ ] T008 [US1] Sort files alphabetically by filename in /app.js
- [ ] T009 [US1] Populate tab bar with file names in /app.js
- [ ] T010 [US1] Visually indicate currently selected file tab in /app.js
- [ ] T011 [US1] Detect single-file Gists and hide file selector in /app.js
- [ ] T012 [US1] Default to first file (alphabetically) on load in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Switch Between Files (Priority: P1)

**Goal**: User can click file tabs to switch between files

**Independent Test**: Click different files in the selector and verify the content updates.

### Implementation for User Story 2

- [ ] T013 [US2] Add click event listeners to file tabs in /app.js
- [ ] T014 [US2] Update currentFile state when tab is clicked in /app.js
- [ ] T015 [US2] Fetch and display selected file content in /app.js
- [ ] T016 [US2] Update visual indicator to show newly selected file in /app.js
- [ ] T017 [US2] Render Markdown files with existing Markdown renderer in /app.js
- [ ] T018 [US2] Render non-Markdown files with syntax highlighting in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Maintain Separate Comments Per File (Priority: P2)

**Goal**: Comments and highlights are file-specific

**Independent Test**: Create comments on different files and verify each file shows only its own comments.

### Implementation for User Story 3

- [ ] T019 [US3] Include filename in comment anchor metadata (front matter) in /app.js
- [ ] T020 [US3] Filter comments by selected file when displaying in /app.js
- [ ] T021 [US3] Filter highlights by selected file in /app.js
- [ ] T022 [US3] Update comments and highlights when file selection changes in /app.js

**Checkpoint**: At this point, User Stories 1, 2, AND 3 should all work independently

---

## Phase 6: User Story 4 - Preserve File Selection in URL (Priority: P3)

**Goal**: File selection is preserved in URL for shareability

**Independent Test**: Select a file, copy the URL, open in new tab, and verify the same file is selected.

### Implementation for User Story 4

- [ ] T023 [US4] Update URL with file parameter when file is selected (?gist=abc&file=readme.md) in /app.js
- [ ] T024 [US4] Parse file parameter from URL on page load in /app.js
- [ ] T025 [US4] Select specified file from URL parameter in /app.js
- [ ] T026 [US4] Handle missing file parameter (default to first file) in /app.js
- [ ] T027 [US4] Handle invalid file parameter (file doesn't exist) gracefully in /app.js
- [ ] T028 [US4] URL-encode filenames with special characters in /app.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T029 Handle Gists with many files (20+) with scrollable tab bar in /styles.css
- [ ] T030 Verify file selector displays within 1 second of loading
- [ ] T031 Verify switching files updates content within 500 milliseconds
- [ ] T032 Run quickstart.md verification steps
- [ ] T033 Test with various multi-file Gist configurations

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-6)**: All depend on Foundational phase completion
  - US2 depends on US1 for file list
  - US3 depends on US2 for file switching
  - US4 can start after US2
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - File list display
- **User Story 2 (P1)**: Depends on US1 - File switching
- **User Story 3 (P2)**: Depends on US2 - Comment filtering
- **User Story 4 (P3)**: Depends on US2 - URL state

### Within Each User Story

- Data extraction before rendering
- State management before UI updates
- Core functionality before URL sync
- Story complete before moving to next priority

### Parallel Opportunities

- T003, T004 can run in parallel (HTML and CSS)
- T007, T008 can run in parallel (file list processing)
- T19, T20, T21 can run in parallel (file filtering)
- T23, T24 can run in parallel (URL read/write)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 33 |
| User Story 1 Tasks | 6 |
| User Story 2 Tasks | 6 |
| User Story 3 Tasks | 4 |
| User Story 4 Tasks | 6 |
| Setup/Foundational Tasks | 6 |
| Polish Tasks | 5 |
| Parallel Opportunities | 8 |
| MVP Scope | Phase 1-4 (US1 + US2) |
