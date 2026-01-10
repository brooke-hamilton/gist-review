# Tasks: Comment Thread Display

**Input**: Design documents from `/specs/11-comment-thread-display/`
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

- [ ] T001 Verify Spec 7 (Display Comments) is complete with comment data
- [ ] T002 Verify Spec 10 (Visual Anchoring) is complete with highlight clicking

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create thread panel element in sidebar in /index.html
- [ ] T004 Add close button to thread panel in /index.html
- [ ] T005 Add reply input area at bottom of thread panel in /index.html
- [ ] T006 [P] Add thread panel styles (expanded sidebar view) in /styles.css
- [ ] T007 [P] Add close button styles in /styles.css
- [ ] T008 Create formatRelativeTime() utility (e.g., "2 hours ago") in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Comment Detail on Highlight Click (Priority: P1) 🎯 MVP

**Goal**: Clicking a highlight opens the comment in a detailed view

**Independent Test**: Click a highlight and verify the comment detail appears in a focused view.

### Implementation for User Story 1

- [ ] T009 [US1] Handle highlight click event to open thread panel in /app.js
- [ ] T010 [US1] Display comment author avatar and username in thread panel in /app.js
- [ ] T011 [US1] Display comment timestamp as relative time in thread panel in /app.js
- [ ] T012 [US1] Add hover tooltip showing absolute timestamp in /app.js
- [ ] T013 [US1] Render comment body as Markdown in thread panel in /app.js
- [ ] T014 [US1] Scroll sidebar to show thread panel in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - View Grouped Comments as Thread (Priority: P1)

**Goal**: Comments with same or overlapping anchors are grouped as a thread

**Independent Test**: Click a highlight with multiple comments and verify all are shown as a thread.

### Implementation for User Story 2

- [ ] T015 [US2] Implement findRelatedComments() to detect overlapping anchors in /app.js
- [ ] T016 [US2] Compare line and offset ranges to determine overlap in /app.js
- [ ] T017 [US2] Group overlapping comments into thread structure in /app.js
- [ ] T018 [US2] Display all thread comments in thread panel in /app.js
- [ ] T019 [US2] Order thread comments chronologically (oldest first) in /app.js
- [ ] T020 [US2] Show thread comment count indicator on highlight in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - View Comment Author and Timestamp (Priority: P2)

**Goal**: Each comment in thread shows author and timestamp metadata

**Independent Test**: Open any comment and verify author name/avatar and timestamp are visible.

### Implementation for User Story 3

- [ ] T021 [US3] Display author for each comment in multi-comment thread in /app.js
- [ ] T022 [US3] Display individual timestamps for each thread comment in /app.js
- [ ] T023 [US3] Handle deleted/unknown author gracefully ("Unknown User") in /app.js
- [ ] T024 [P] [US3] Add thread comment card styles (author, timestamp, body) in /styles.css

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Thread Interaction

**Purpose**: Enable closing thread panel and replying to threads

- [ ] T025 Implement close button click handler to hide thread panel in /app.js
- [ ] T026 Implement click-outside to close thread panel in /app.js
- [ ] T027 Filter thread to only show comments from current revision in /app.js
- [ ] T028 Enable reply input for authenticated users in /app.js
- [ ] T029 Submit reply as new anchored comment (reuse Spec 9 logic) in /app.js

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T030 Handle large threads (10+ comments) with scrolling in /styles.css
- [ ] T031 Verify clicking highlight opens focused view within 500 milliseconds
- [ ] T032 Run quickstart.md verification steps
- [ ] T033 Test with various thread configurations

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 depends on US1 for basic thread panel
- **Thread Interaction (Phase 6)**: Depends on US1 for thread panel
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Single comment view
- **User Story 2 (P1)**: Depends on US1 - Thread grouping
- **User Story 3 (P2)**: Can start after US1 - Metadata display

### Within Each User Story

- Event handling before rendering
- Logic before styling
- Single comment before multiple comments
- Story complete before moving to next priority

### Parallel Opportunities

- T003, T004, T005, T006, T007 can run in parallel (HTML/CSS setup)
- T009, T010, T11 can run in parallel (thread panel population)
- T24 can run in parallel with T21-T23 (CSS styling)
- T25, T26 can run in parallel (close handlers)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 33 |
| User Story 1 Tasks | 6 |
| User Story 2 Tasks | 6 |
| User Story 3 Tasks | 4 |
| Setup/Foundational Tasks | 8 |
| Thread Interaction Tasks | 5 |
| Polish Tasks | 4 |
| Parallel Opportunities | 8 |
| MVP Scope | Phase 1-4 (US1 + US2) |
