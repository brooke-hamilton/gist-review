# Tasks: Create Anchored Comment

**Input**: Design documents from `/specs/9-create-anchored-comment/`
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

- [ ] T001 Verify Spec 6 (GitHub OAuth) is complete for authenticated API requests
- [ ] T002 Verify Spec 7 (Display Comments) is complete for showing new comments
- [ ] T003 Verify Spec 8 (Text Selection) is complete for selection metadata

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Extend selection popover with comment input form (textarea + submit button) in /index.html
- [ ] T005 Add preview toggle/tab to comment form in /index.html
- [ ] T006 [P] Add comment form styles in /styles.css
- [ ] T007 [P] Add preview area styles in /styles.css
- [ ] T008 Create buildFrontMatter() function for YAML serialization in /app.js
- [ ] T009 Create submitComment() function skeleton in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Create Comment on Selected Text (Priority: P1) 🎯 MVP

**Goal**: Authenticated user creates a comment anchored to their text selection

**Independent Test**: Log in, select text, enter a comment, submit, and verify the comment appears on GitHub.

### Implementation for User Story 1

- [ ] T010 [US1] Show comment form in popover when text is selected in /app.js
- [ ] T011 [US1] Add submit button click handler in /app.js
- [ ] T012 [US1] Validate comment text is not empty before submission in /app.js
- [ ] T013 [US1] Implement submitComment() to call GitHub Gist Comments API in /app.js
- [ ] T014 [US1] Include auth token in API request headers in /app.js
- [ ] T015 [US1] Show loading state during submission in /app.js
- [ ] T016 [US1] Handle successful submission (clear form, show success) in /app.js
- [ ] T017 [US1] Add new comment to sidebar immediately after success in /app.js
- [ ] T018 [US1] Close popover after successful submission in /app.js
- [ ] T019 [US1] Handle submission errors with user-friendly messages in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Embed Selection Metadata in Comment (Priority: P1)

**Goal**: Created comments contain YAML front matter with anchoring metadata

**Independent Test**: Create a comment and inspect raw body on GitHub to verify YAML front matter.

### Implementation for User Story 2

- [ ] T020 [US2] Build front matter with line_start field in /app.js
- [ ] T021 [US2] Build front matter with line_end field in /app.js
- [ ] T022 [US2] Build front matter with offset_start field in /app.js
- [ ] T023 [US2] Build front matter with offset_end field in /app.js
- [ ] T024 [US2] Build front matter with selected_text field in /app.js
- [ ] T025 [US2] Build front matter with revision field (current Gist revision ID) in /app.js
- [ ] T026 [US2] Build front matter with file field (current file name) in /app.js
- [ ] T027 [US2] Properly escape special characters in YAML (quotes, colons, etc.) in /app.js
- [ ] T028 [US2] Combine front matter and comment body into full comment text in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Prompt Login for Unauthenticated Users (Priority: P2)

**Goal**: Unauthenticated users see login prompt when attempting to comment

**Independent Test**: Select text while logged out and verify a "login to comment" message appears.

### Implementation for User Story 3

- [ ] T029 [US3] Check auth state when user attempts to comment in /app.js
- [ ] T030 [US3] Show "Log in to comment" message for unauthenticated users in /app.js
- [ ] T031 [US3] Add login button to popover for unauthenticated users in /app.js
- [ ] T032 [US3] Trigger OAuth flow when login button is clicked in /app.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Comment Preview

**Purpose**: Enable users to preview their comment as rendered Markdown

- [ ] T033 Implement preview toggle functionality in /app.js
- [ ] T034 Render comment body as Markdown in preview area in /app.js
- [ ] T035 Switch between edit and preview views in /app.js

---

## Phase 7: Draft Preservation

**Purpose**: Preserve comment draft during re-authentication

- [ ] T036 Store comment draft in sessionStorage when auth expires in /app.js
- [ ] T037 Detect auth expiration during submission in /app.js
- [ ] T038 Restore comment draft after successful re-authentication in /app.js
- [ ] T039 Clear draft from sessionStorage after successful submission in /app.js

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T040 Handle network errors during submission with retry option in /app.js
- [ ] T041 Verify comment appears on GitHub within 5 seconds of submission
- [ ] T042 Run quickstart.md verification steps
- [ ] T043 Test with various Markdown content in comments

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 should run in parallel with US1 (both P1)
- **Comment Preview (Phase 6)**: Can run after Foundational
- **Draft Preservation (Phase 7)**: Depends on US1 for submission flow
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Core submission
- **User Story 2 (P1)**: Should run in parallel with US1 - Front matter creation
- **User Story 3 (P2)**: Can start after US1 - Auth handling

### Within Each User Story

- UI elements before logic
- Validation before submission
- Success handling before error handling
- Story complete before moving to next priority

### Parallel Opportunities

- T004, T005, T006, T007 can run in parallel (HTML/CSS setup)
- T020-T26 can run in parallel (front matter fields)
- T033, T34, T35 can run in parallel (preview feature)
- US1 and US2 can run in parallel

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 43 |
| User Story 1 Tasks | 10 |
| User Story 2 Tasks | 9 |
| User Story 3 Tasks | 4 |
| Setup/Foundational Tasks | 9 |
| Comment Preview Tasks | 3 |
| Draft Preservation Tasks | 4 |
| Polish Tasks | 4 |
| Parallel Opportunities | 10 |
| MVP Scope | Phase 1-4 (US1 + US2) |
