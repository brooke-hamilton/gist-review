# Tasks: GitHub OAuth Authentication

**Input**: Design documents from `/specs/6-github-oauth/`
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

- [ ] T001 Verify Spec 1 (Static Site Foundation) header UI is ready for login button
- [ ] T002 Create GitHub OAuth App with Device Flow enabled (document client_id)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create auth state management object (isLoggedIn, accessToken, userProfile) in /app.js
- [ ] T004 Create localStorage helper functions (saveAuth, loadAuth, clearAuth) in /app.js
- [ ] T005 Add login button element to header in /index.html
- [ ] T006 Add logout button element to header (hidden by default) in /index.html
- [ ] T007 [P] Add login/logout button styles in /styles.css
- [ ] T008 Create Device Flow modal dialog element in /index.html
- [ ] T009 [P] Add modal dialog styles in /styles.css

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Log In with GitHub (Priority: P1) 🎯 MVP

**Goal**: User clicks login, completes GitHub OAuth Device Flow, and sees logged-in state

**Independent Test**: Click login, complete GitHub OAuth, and verify the UI shows the logged-in state.

### Implementation for User Story 1

- [ ] T010 [US1] Implement initiateDeviceFlow() to request device code from GitHub in /app.js
- [ ] T011 [US1] Display user code and verification URL in modal dialog in /app.js
- [ ] T012 [US1] Add copy button for user code in modal dialog in /app.js
- [ ] T013 [US1] Add link to GitHub verification page that opens in new tab in /app.js
- [ ] T014 [US1] Implement pollForToken() to poll for access token in /app.js
- [ ] T015 [US1] Request only 'gist' scope during authorization in /app.js
- [ ] T016 [US1] Store access token in localStorage after successful auth in /app.js
- [ ] T017 [US1] Implement fetchUserProfile() to get user info from GitHub API in /app.js
- [ ] T018 [US1] Store user profile (avatar, username) in localStorage in /app.js
- [ ] T019 [US1] Display user avatar and username in header when authenticated in /app.js
- [ ] T020 [US1] Hide login button and show user info when authenticated in /app.js
- [ ] T021 [P] [US1] Add user avatar and username styles in header in /styles.css

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Persist Login State (Priority: P2)

**Goal**: User's authentication persists across page refreshes and browser sessions

**Independent Test**: Log in, close browser, reopen app, and verify logged-in state is retained.

### Implementation for User Story 2

- [ ] T022 [US2] Check localStorage for existing auth on page load in /app.js
- [ ] T023 [US2] Restore auth state and user profile from localStorage in /app.js
- [ ] T024 [US2] Update UI to reflect restored auth state in /app.js
- [ ] T025 [US2] Validate stored token is still valid (optional API check) in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Log Out (Priority: P2)

**Goal**: User can log out and clear their authentication

**Independent Test**: Click logout while logged in and verify the UI shows the logged-out state.

### Implementation for User Story 3

- [ ] T026 [US3] Add click event listener to logout button in /app.js
- [ ] T027 [US3] Implement logout() to clear localStorage auth data in /app.js
- [ ] T028 [US3] Reset UI to logged-out state (show login button, hide user info) in /app.js
- [ ] T029 [US3] Verify logout persists across page refresh in /app.js

**Checkpoint**: At this point, User Stories 1, 2, AND 3 should all work independently

---

## Phase 6: User Story 4 - Local Development OAuth (Priority: P3)

**Goal**: Developer can complete OAuth flow from localhost

**Independent Test**: Run app locally, initiate OAuth, and verify the flow completes successfully.

### Implementation for User Story 4

- [ ] T030 [US4] Configure GitHub OAuth App to support Device Flow (no redirect needed)
- [ ] T031 [US4] Document localhost OAuth setup in README or docs
- [ ] T032 [US4] Test OAuth flow from localhost environment

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T033 Handle OAuth flow cancellation (user closes modal) gracefully in /app.js
- [ ] T034 Detect expired/revoked tokens and prompt re-login in /app.js
- [ ] T035 Display error message for expired session with re-login prompt in /app.js
- [ ] T036 Verify login flow completes within 30 seconds
- [ ] T037 Run quickstart.md verification steps
- [ ] T038 Handle multiple tabs login/logout state detection (optional) in /app.js

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-6)**: All depend on Foundational phase completion
  - US2 and US3 depend on US1 for authentication to exist
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Core login flow
- **User Story 2 (P2)**: Depends on US1 - Persistence of auth state
- **User Story 3 (P2)**: Depends on US1 - Clearing auth state
- **User Story 4 (P3)**: Can start after US1 - Local dev testing

### Within Each User Story

- Backend/API calls before UI updates
- State management before display
- Core functionality before edge cases
- Story complete before moving to next priority

### Parallel Opportunities

- T005, T006, T007, T008, T009 can run in parallel (HTML/CSS setup)
- T010-T015 can run in parallel (Device Flow implementation)
- T021 can run in parallel with T19, T20 (CSS styling)
- US3 and US4 can run in parallel after US1

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 38 |
| User Story 1 Tasks | 12 |
| User Story 2 Tasks | 4 |
| User Story 3 Tasks | 4 |
| User Story 4 Tasks | 3 |
| Setup/Foundational Tasks | 9 |
| Polish Tasks | 6 |
| Parallel Opportunities | 10 |
| MVP Scope | Phase 1-3 (User Story 1) |
