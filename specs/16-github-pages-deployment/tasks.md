# Tasks: GitHub Pages Deployment

**Input**: Design documents from `/specs/16-github-pages-deployment/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: Tests are OPTIONAL - not explicitly requested in this feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: Files at repository root (`/`)
- Structure: `index.html`, `styles.css`, `app.js`, `404.html`, `.github/workflows/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Verify Spec 1 (Static Site Foundation) is complete with deployable static files

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Create .github/workflows/ directory structure
- [ ] T003 Create 404.html for SPA routing support in /404.html
- [ ] T004 Implement 404.html redirect to index.html preserving query params in /404.html

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Access Application at GitHub Pages URL (Priority: P1) 🎯 MVP

**Goal**: Application is accessible at the GitHub Pages URL

**Independent Test**: Navigate to `https://{owner}.github.io/gist-review/` and verify the application loads.

### Implementation for User Story 1

- [ ] T005 [US1] Create GitHub Actions workflow file in /.github/workflows/deploy.yml
- [ ] T006 [US1] Configure workflow to trigger on push to main branch in deploy.yml
- [ ] T007 [US1] Add checkout step to workflow in deploy.yml
- [ ] T008 [US1] Add build/copy step for future extensibility in deploy.yml
- [ ] T009 [US1] Add GitHub Pages deployment step using actions/deploy-pages in deploy.yml
- [ ] T010 [US1] Configure GitHub Pages source to GitHub Actions in deploy.yml
- [ ] T011 [US1] Verify all static files are served correctly (HTML, CSS, JS)
- [ ] T012 [US1] Test application with Gist parameter on GitHub Pages URL

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Automatic Deployment on Push (Priority: P2)

**Goal**: Changes pushed to main branch automatically deploy

**Independent Test**: Push a change to main and verify the GitHub Pages site updates.

### Implementation for User Story 2

- [ ] T013 [US2] Verify workflow runs automatically on push to main
- [ ] T014 [US2] Check deployment status in GitHub Actions tab
- [ ] T015 [US2] Verify site reflects pushed changes within 5 minutes
- [ ] T016 [US2] Add workflow status badge to README in /README.md

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Understand Deployment Process (Priority: P3)

**Goal**: README contains clear deployment documentation

**Independent Test**: Read README and verify deployment instructions are present and clear.

### Implementation for User Story 3

- [ ] T017 [US3] Add "Deployment" section to README in /README.md
- [ ] T018 [US3] Document GitHub Pages configuration in README in /README.md
- [ ] T019 [US3] Document how to verify successful deployment in README in /README.md
- [ ] T020 [US3] Document workflow file location and purpose in README in /README.md
- [ ] T021 [US3] Add link to live site in README in /README.md

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T022 Verify URL parameter routing works on GitHub Pages (no 404s for query params)
- [ ] T023 Test 404.html redirect preserves ?gist=xxx parameter
- [ ] T024 Verify deployment completes within 5 minutes
- [ ] T025 Verify all features work identically on GitHub Pages and local development
- [ ] T026 Run quickstart.md verification steps
- [ ] T027 Document custom domain configuration option (optional) in README

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 depends on US1 for initial deployment
  - US3 depends on US1 for deployment to document
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - GitHub Actions workflow
- **User Story 2 (P2)**: Depends on US1 - Automatic deployment
- **User Story 3 (P3)**: Depends on US1 - Documentation

### Within Each User Story

- Workflow configuration before testing
- Deployment before documentation
- Core functionality before optional features
- Story complete before moving to next priority

### Parallel Opportunities

- T003, T004 can run in parallel (404.html)
- T005-T10 can run in parallel (workflow configuration)
- T017-T21 can run in parallel (README documentation)
- T022-T27 can run in parallel (verification tasks)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 27 |
| User Story 1 Tasks | 8 |
| User Story 2 Tasks | 4 |
| User Story 3 Tasks | 5 |
| Setup/Foundational Tasks | 4 |
| Polish Tasks | 6 |
| Parallel Opportunities | 8 |
| MVP Scope | Phase 1-3 (User Story 1) |
