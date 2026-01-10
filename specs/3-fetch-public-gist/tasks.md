# Tasks: Fetch and Display Public Gist

**Input**: Design documents from `/specs/3-fetch-public-gist/`
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

- [ ] T001 Verify Spec 2 (URL Parameter Routing) is complete and provides extracted Gist ID

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Create fetchGist() function skeleton with 10-second timeout in /app.js
- [ ] T003 Create GitHub Gist API URL builder function (<https://api.github.com/gists/{id}>) in /app.js
- [ ] T004 Create loading indicator UI element in /index.html
- [ ] T005 [P] Add loading indicator styles in /styles.css

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Public Gist Content (Priority: P1) 🎯 MVP

**Goal**: User navigates with a valid Gist ID and sees the raw Markdown content of the first file

**Independent Test**: Navigate to `?gist={valid_public_gist_id}` and verify the Markdown content appears as raw text.

### Implementation for User Story 1

- [ ] T006 [US1] Implement fetchGist() function using native Fetch API in /app.js
- [ ] T007 [US1] Add 10-second timeout handling with AbortController in /app.js
- [ ] T008 [US1] Parse Gist API response to extract files object in /app.js
- [ ] T009 [US1] Implement getFirstFile() to select first file alphabetically in /app.js
- [ ] T010 [US1] Extract raw content from first file in /app.js
- [ ] T011 [US1] Display raw Markdown content in main content area in /app.js
- [ ] T012 [US1] Show loading indicator while fetching in /app.js
- [ ] T013 [US1] Hide loading indicator when content loads in /app.js
- [ ] T014 [US1] Style content display area for raw text in /styles.css

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Handle Invalid Gist ID (Priority: P2)

**Goal**: User sees a clear error message when Gist doesn't exist

**Independent Test**: Navigate to `?gist=invalid123xyz` and verify an appropriate error message appears.

### Implementation for User Story 2

- [ ] T015 [US2] Implement error handling for 404 response in /app.js
- [ ] T016 [US2] Create displayError() function for user-friendly error messages in /app.js
- [ ] T017 [US2] Display "Gist not found. Please check the Gist ID and try again." message in /app.js
- [ ] T018 [US2] Handle private Gist access (403/404) with appropriate message in /app.js
- [ ] T019 [US2] Handle empty Gist (no files) with appropriate message in /app.js
- [ ] T020 [P] [US2] Style error message display in /styles.css

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Handle Network Failures (Priority: P3)

**Goal**: User sees helpful message with retry option when network fails

**Independent Test**: Simulate network failure (offline mode) and verify an error message with retry option appears.

### Implementation for User Story 3

- [ ] T021 [US3] Implement network error detection (TypeError from fetch) in /app.js
- [ ] T022 [US3] Display "Unable to connect. Please check your internet connection." message in /app.js
- [ ] T023 [US3] Add retry button to error display in /index.html and /app.js
- [ ] T024 [US3] Implement retry functionality that re-initiates fetch in /app.js
- [ ] T025 [US3] Show loading indicator during retry in /app.js
- [ ] T026 [US3] Handle timeout errors with specific timeout message in /app.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T027 Implement rate limit error handling with reset time display in /app.js
- [ ] T028 Parse X-RateLimit-Reset header to show estimated reset time in /app.js
- [ ] T029 Verify content displays within 3 seconds on standard connection
- [ ] T030 Run quickstart.md verification steps
- [ ] T031 Test with various public Gists to verify compatibility

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after US1 - Extends error handling
- **User Story 3 (P3)**: Can start after US2 - Adds retry functionality to errors

### Within Each User Story

- Fetch logic before display logic
- Success path before error handling
- Logic before styling
- Story complete before moving to next priority

### Parallel Opportunities

- T004, T005 can run in parallel (HTML and CSS)
- T015, T016 can run in parallel (error handling setup)
- T020 can run in parallel with other US2 tasks (CSS styling)
- T027, T028 can run in parallel (rate limit handling)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 31 |
| User Story 1 Tasks | 9 |
| User Story 2 Tasks | 6 |
| User Story 3 Tasks | 6 |
| Setup/Foundational Tasks | 5 |
| Polish Tasks | 5 |
| Parallel Opportunities | 6 |
| MVP Scope | Phase 1-3 (User Story 1) |
