# Research: Static Site Foundation

**Feature**: 1-static-site-foundation  
**Date**: 2026-01-10

## Research Tasks

### 1. Responsive CSS Strategy (Mobile-First with Single Breakpoint)

**Decision**: Use CSS custom properties (variables) for theming and a mobile-first approach with single breakpoint at 768px.

**Rationale**:

- Mobile-first ensures good base experience on smaller devices
- Single breakpoint at 768px aligns with tablet portrait mode
- CSS custom properties enable easy dark/light theme switching
- No CSS framework needed for this simple layout

**Alternatives Considered**:

- CSS framework (Bootstrap, Tailwind) - Rejected: Adds build complexity, violates zero-toolchain requirement
- Multiple breakpoints - Rejected: Spec explicitly calls for single breakpoint at 768px

### 2. Color Scheme Detection

**Decision**: Use `prefers-color-scheme` media query with CSS custom properties for light/dark theme support.

**Rationale**:

- Native browser support, no JavaScript required
- CSS custom properties allow theme colors to cascade naturally
- Respects user's system preference automatically

**Alternatives Considered**:

- JavaScript-based theme detection - Rejected: CSS-only solution is simpler and faster
- Manual theme toggle only - Rejected: Spec requires respecting system preference

### 3. Semantic HTML Structure

**Decision**: Use HTML5 semantic elements: `<header>`, `<main>`, `<footer>`, `<nav>`, `<article>`.

**Rationale**:

- Improves accessibility for screen readers
- Provides better SEO structure
- Required by FR-007 in the spec

**Alternatives Considered**:

- Generic `<div>` elements with ARIA roles - Rejected: Semantic elements are more semantic and simpler

### 4. Content Width Constraints

**Decision**: Use `max-width: 1200px` on main content with `margin: 0 auto` for centering.

**Rationale**:

- Prevents content from becoming too wide on large screens
- Improves readability by limiting line length
- Explicitly required by FR-008

**Alternatives Considered**:

- Full-width layout - Rejected: Poor readability on wide screens
- Smaller max-width (800px) - Rejected: Spec explicitly requires 1200px

### 5. Local Development Server

**Decision**: Document both `python -m http.server` and `npx serve` as options.

**Rationale**:

- Python is commonly available on developer machines
- npx serve provides a quick alternative for Node.js users
- Both serve static files correctly without configuration

**Alternatives Considered**:

- Custom dev server script - Rejected: Adds complexity, spec requires simple HTTP servers work
- Live reload server - Rejected: Nice-to-have but not required

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| CSS Methodology | Mobile-first with CSS custom properties | Simple, no build required |
| Theming | `prefers-color-scheme` media query | Native, respects system preference |
| HTML Structure | Semantic HTML5 elements | Accessibility, SEO |
| Content Width | max-width 1200px, centered | Readability on large screens |
| Local Dev | python/npx serve | Spec requirement, simple |
