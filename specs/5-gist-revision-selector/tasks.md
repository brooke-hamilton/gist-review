# Tasks: Gist Revision Selector

**Input**: Design documents from `/specs/5-gist-revision-selector/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md, contracts/

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

- [ ] T001 Verify Spec 3 (Fetch Public Gist) is complete and provides Gist data
- [ ] T002 Verify Spec 4 (Markdown Rendering) is complete for content display

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create fetchGistRevisions() function skeleton in /app.js
- [ ] T004 Create revision selector dropdown element in /index.html
- [ ] T005 [P] Add dropdown/select styles in /styles.css
- [ ] T006 Create formatTimestamp() utility for absolute timestamps (e.g., "Jan 8, 2026 2:30 PM") in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Revision History (Priority: P1) 🎯 MVP

**Goal**: User loads a Gist and sees a dropdown listing all available revisions

**Independent Test**: Load a Gist with multiple revisions and verify a list of revisions appears in the UI.

### Implementation for User Story 1

- [ ] T007 [US1] Implement fetchGistRevisions() to call GitHub Gist API for history in /app.js
- [ ] T008 [US1] Parse revision history from API response in /app.js
- [ ] T009 [US1] Populate revision dropdown with revision entries in /app.js
- [ ] T010 [US1] Display absolute timestamp for each revision in dropdown in /app.js
- [ ] T011 [US1] Handle single-revision Gists (show the one revision as current) in /app.js
- [ ] T012 [US1] Show loading state while fetching revision history in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Select and View a Specific Revision (Priority: P1)

**Goal**: User selects a revision and the content updates to show that revision

**Independent Test**: Select a non-current revision and verify the displayed content changes.

### Implementation for User Story 2

- [ ] T013 [US2] Add change event listener to revision dropdown in /app.js
- [ ] T014 [US2] Implement fetchRevisionContent() to fetch content for selected revision in /app.js
- [ ] T015 [US2] Update content display with selected revision content in /app.js
- [ ] T016 [US2] Show loading indicator while fetching revision content in /app.js
- [ ] T017 [US2] Handle revision fetch errors gracefully with user-friendly messages in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Identify Current Revision (Priority: P2)

**Goal**: User can clearly see which revision is currently displayed

**Independent Test**: Check that the currently displayed revision is visually highlighted in the selector.

### Implementation for User Story 3

- [ ] T018 [US3] Visually indicate the currently selected revision in dropdown in /app.js
- [ ] T019 [US3] Default to latest revision when Gist is first loaded in /app.js
- [ ] T020 [US3] Update visual indicator when revision selection changes in /app.js
- [ ] T021 [P] [US3] Style the selected/current revision indicator in /styles.css

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: URL State Synchronization

**Purpose**: Enable shareable revision-specific URLs

- [ ] T022 Implement URL update with revision parameter (?gist=abc&rev=xyz) in /app.js
- [ ] T023 Parse revision parameter from URL on page load in /app.js
- [ ] T024 Load specified revision when URL contains rev parameter in /app.js
- [ ] T025 Implement browser history support (pushState) for revision changes in /app.js
- [ ] T026 Support browser back/forward navigation between revisions in /app.js

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T027 Handle Gists with many revisions (50+) with scrollable dropdown in /styles.css
- [ ] T028 Verify revision list displays within 3 seconds of loading a Gist
- [ ] T029 Verify switching revisions updates content within 2 seconds
- [ ] T030 Run quickstart.md verification steps
- [ ] T031 Test with multi-revision Gists to verify functionality

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US1 and US2 are both P1 and should be done in sequence
- **URL State (Phase 6)**: Depends on US2 for revision selection
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Displays revision list
- **User Story 2 (P1)**: Depends on US1 - Enables revision selection
- **User Story 3 (P2)**: Can start after US2 - Visual feedback

### Within Each User Story

- API calls before UI updates
- Logic before styling
- Core functionality before URL sync
- Story complete before moving to next priority

### Parallel Opportunities

- T004, T005 can run in parallel (HTML and CSS)
- T007, T008 can run in parallel (API and parsing)
- T021 can run in parallel with T018, T019, T020 (CSS styling)
- T027 can run in parallel with other polish tasks

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 31 |
| User Story 1 Tasks | 6 |
| User Story 2 Tasks | 5 |
| User Story 3 Tasks | 4 |
| Setup/Foundational Tasks | 6 |
| URL State Tasks | 5 |
| Polish Tasks | 5 |
| Parallel Opportunities | 6 |
| MVP Scope | Phase 1-4 (US1 + US2) |
