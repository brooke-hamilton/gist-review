# Tasks: Visual Comment Anchoring

**Input**: Design documents from `/specs/10-visual-comment-anchoring/`
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

- [ ] T001 Verify Spec 5 (Revision Selector) is complete for revision switching
- [ ] T002 Verify Spec 7 (Display Comments) is complete with parsed front matter
- [ ] T003 Verify Spec 8 (Text Selection) provides line/offset mapping understanding

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Create highlight overlay container element in /index.html
- [ ] T005 [P] Add highlight base styles (semi-transparent yellow/amber background) in /styles.css
- [ ] T006 [P] Add highlight hover styles (darker background, pointer cursor) in /styles.css
- [ ] T007 Create renderHighlights() function skeleton in /app.js
- [ ] T008 Create highlightTextRange() function to wrap text in highlight span in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - See Highlighted Text with Comments (Priority: P1) 🎯 MVP

**Goal**: Text regions with comments are visually highlighted in the rendered content

**Independent Test**: Load a Gist with anchored comments and verify associated text regions are highlighted.

### Implementation for User Story 1

- [ ] T009 [US1] Extract anchor metadata (line, offsets) from comment front matter in /app.js
- [ ] T010 [US1] Map anchor metadata to DOM positions using line mapping in /app.js
- [ ] T011 [US1] Create highlight spans around anchored text regions in /app.js
- [ ] T012 [US1] Store comment reference on highlight element (data attribute) in /app.js
- [ ] T013 [US1] Handle multiple comments on different regions in /app.js
- [ ] T014 [US1] Handle highlights that span multiple elements in /app.js
- [ ] T015 [US1] Call renderHighlights() after comments are loaded in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Filter Highlights by Revision (Priority: P1)

**Goal**: Highlights only show for comments matching the current revision

**Independent Test**: Load a Gist with comments on different revisions, switch revisions, and verify highlights update.

### Implementation for User Story 2

- [ ] T016 [US2] Filter comments by current revision ID before rendering highlights in /app.js
- [ ] T017 [US2] Listen for revision change events in /app.js
- [ ] T018 [US2] Clear existing highlights when revision changes in /app.js
- [ ] T019 [US2] Re-render highlights for new revision's comments in /app.js
- [ ] T020 [US2] Handle case where revision has no comments (no highlights) in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Click Highlight to Focus Comment (Priority: P2)

**Goal**: Clicking a highlight scrolls to and focuses the associated comment in sidebar

**Independent Test**: Click a highlight and verify the associated comment scrolls into view in the sidebar.

### Implementation for User Story 3

- [ ] T021 [US3] Add click event listener to highlight elements in /app.js
- [ ] T022 [US3] Implement scrollToComment() to scroll sidebar to comment in /app.js
- [ ] T023 [US3] Add visual focus state to target comment in sidebar in /app.js
- [ ] T024 [US3] Handle overlapping highlights (multiple comments on same text) in /app.js
- [ ] T025 [US3] Show popup menu when clicking overlapping anchors in /app.js
- [ ] T026 [US3] Allow user to select which comment to focus from popup in /app.js
- [ ] T027 [P] [US3] Add focused comment styles in sidebar in /styles.css
- [ ] T028 [P] [US3] Add popup menu styles for overlapping anchors in /styles.css

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Orphaned Comment Handling

**Purpose**: Handle comments whose anchored text no longer exists

- [ ] T029 Detect orphaned comments (anchor position doesn't exist in current content) in /app.js
- [ ] T030 Skip highlight rendering for orphaned comments in /app.js
- [ ] T031 Display orphaned comments in sidebar with warning icon in /app.js
- [ ] T032 Add tooltip explaining anchor is outdated in /app.js
- [ ] T033 [P] Add muted/warning styles for orphaned comments in /styles.css

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T034 Handle very small highlighted regions (1-2 characters) in /app.js
- [ ] T035 Verify highlights render within 1 second of content display
- [ ] T036 Verify clicking highlight focuses comment within 500 milliseconds
- [ ] T037 Run quickstart.md verification steps
- [ ] T038 Test with various anchored comment configurations

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 should run in parallel with US1 (both P1)
- **Orphaned Comment Handling (Phase 6)**: Depends on US1 for highlight rendering
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Core highlighting
- **User Story 2 (P1)**: Can start after US1 - Revision filtering
- **User Story 3 (P2)**: Depends on US1 - Click interaction

### Within Each User Story

- Data extraction before rendering
- Rendering before interaction
- Logic before styling
- Story complete before moving to next priority

### Parallel Opportunities

- T005, T006 can run in parallel (CSS styling)
- T009, T010 can run in parallel (metadata extraction)
- T027, T028 can run in parallel with T21-T26 (CSS styling)
- T033 can run in parallel with T29-T32 (orphan styling)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 38 |
| User Story 1 Tasks | 7 |
| User Story 2 Tasks | 5 |
| User Story 3 Tasks | 8 |
| Setup/Foundational Tasks | 8 |
| Orphaned Comment Tasks | 5 |
| Polish Tasks | 5 |
| Parallel Opportunities | 6 |
| MVP Scope | Phase 1-4 (US1 + US2) |
