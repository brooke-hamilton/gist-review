# Tasks: Text Selection Capture

**Input**: Design documents from `/specs/8-text-selection-capture/`
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

- [ ] T001 Verify Spec 4 (Markdown Rendering) is complete and provides rendered HTML content

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Create line mapping data structure to map rendered HTML to source Markdown lines in /app.js
- [ ] T003 Implement buildLineMap() to create HTML-to-Markdown line mapping during rendering in /app.js
- [ ] T004 Create selection popover element in /index.html
- [ ] T005 [P] Add popover positioning and styling in /styles.css
- [ ] T006 Create TextSelection class/object structure (text, startLine, endLine, startOffset, endOffset) in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Select Text and View Selection Metadata (Priority: P1) 🎯 MVP

**Goal**: User selects text and sees selection metadata in a popover near the selection

**Independent Test**: Select text in the rendered Markdown and verify selection metadata appears in a popover.

### Implementation for User Story 1

- [ ] T007 [US1] Add selectionchange event listener to rendered content area in /app.js
- [ ] T008 [US1] Create getSelectionData() function using native Selection API in /app.js
- [ ] T009 [US1] Extract selected text content from selection in /app.js
- [ ] T010 [US1] Implement minimum character threshold (3+ characters) for showing popover in /app.js
- [ ] T011 [US1] Ignore whitespace-only selections in /app.js
- [ ] T012 [US1] Calculate popover position near selected text in /app.js
- [ ] T013 [US1] Display selected text preview in popover in /app.js
- [ ] T014 [US1] Show popover when valid selection is made in /app.js
- [ ] T015 [US1] Hide popover when selection is cleared or changes to invalid in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Accurate Line Number Capture (Priority: P1)

**Goal**: Selection metadata includes accurate source Markdown line numbers

**Independent Test**: Select text on various lines and verify the reported line numbers match the original Markdown.

### Implementation for User Story 2

- [ ] T016 [US2] Implement getSourceLineNumber() to map DOM position to Markdown line in /app.js
- [ ] T017 [US2] Add data-line attributes to rendered elements during Markdown rendering in /app.js
- [ ] T018 [US2] Calculate start line number from selection anchor node in /app.js
- [ ] T019 [US2] Calculate end line number from selection focus node (for multi-line) in /app.js
- [ ] T020 [US2] Handle selections in nested elements (lists, blockquotes) in /app.js
- [ ] T021 [US2] Handle selections in code blocks in /app.js
- [ ] T022 [US2] Display line number(s) in popover in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Accurate Character Offset Capture (Priority: P2)

**Goal**: Selection metadata includes accurate character offsets within lines

**Independent Test**: Select partial text on a line and verify the offsets match the selection position.

### Implementation for User Story 3

- [ ] T023 [US3] Calculate start offset within the line in /app.js
- [ ] T024 [US3] Calculate end offset within the line in /app.js
- [ ] T025 [US3] Handle offsets for selections crossing element boundaries in /app.js
- [ ] T026 [US3] Display offset information in popover in /app.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T027 Handle selections across rendered element boundaries (bold + normal text) in /app.js
- [ ] T028 Ensure popover doesn't overflow viewport boundaries in /app.js
- [ ] T029 Verify selection metadata appears within 200 milliseconds in /app.js
- [ ] T030 Run quickstart.md verification steps
- [ ] T031 Test with various Markdown content including edge cases

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 should run in parallel with or immediately after US1 (both P1)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Core selection detection
- **User Story 2 (P1)**: Depends on US1 - Line number mapping
- **User Story 3 (P2)**: Depends on US2 - Character offset calculation

### Within Each User Story

- Event handling before data extraction
- Data extraction before display
- Logic before styling
- Story complete before moving to next priority

### Parallel Opportunities

- T004, T005 can run in parallel (HTML and CSS)
- T007, T008 can run in parallel (event handling setup)
- T016, T17 can run in parallel (line mapping)
- T23, T24 can run in parallel (offset calculation)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 31 |
| User Story 1 Tasks | 9 |
| User Story 2 Tasks | 7 |
| User Story 3 Tasks | 4 |
| Setup/Foundational Tasks | 6 |
| Polish Tasks | 5 |
| Parallel Opportunities | 6 |
| MVP Scope | Phase 1-4 (US1 + US2) |
