# Data Model: Accessibility Enhancements

**Feature**: 14-accessibility-enhancements  
**Date**: 2026-01-10

## Overview

This feature adds accessibility infrastructure and keyboard navigation throughout the application.

## Entities

### FocusState

Tracks current focus context.

| Field | Type | Description |
|-------|------|-------------|
| activeModal | HTMLElement \| null | Currently open modal |
| previousFocus | HTMLElement \| null | Element to return focus to |
| trapActive | boolean | Whether focus trap is active |

### KeyboardShortcut

Defines a keyboard shortcut.

| Field | Type | Description |
|-------|------|-------------|
| key | string | Key code (e.g., 'Escape') |
| description | string | Human-readable description |
| handler | Function | Action to perform |
| context | string \| null | Context where applicable |

## State Management

### Extended Application State

```javascript
{
  // ... existing state
  accessibility: {
    activeModal: null,
    previousFocus: null,
    shortcuts: [
      { key: 'Escape', description: 'Close modal', handler: closeModal },
      { key: '/', description: 'Focus search', handler: focusSearch },
      { key: '?', description: 'Show keyboard help', handler: showHelp }
    ]
  }
}
```

## Functions

### setupFocusIndicators(): void

Ensures all interactive elements have visible focus styles.

### addSkipLink(): void

Adds skip-to-content link at top of page.

### setupAriaLabels(): void

Adds ARIA labels to all custom components.

### createLiveRegions(): void

Creates polite and assertive live regions.

### announceStatus(message: string): void

Announces message via polite live region.

### announceError(message: string): void

Announces error via assertive live region.

### openModal(modal: HTMLElement): void

Opens modal with focus management.

### closeModal(): void

Closes modal and returns focus.

### trapFocus(container: HTMLElement): void

Sets up focus trapping within container.

### releaseFocusTrap(): void

Removes focus trap.

### setupKeyboardShortcuts(): void

Registers global keyboard shortcuts.

### showKeyboardHelp(): void

Displays keyboard shortcut help dialog.

### makeHighlightsFocusable(): void

Adds tabindex and keyboard handlers to highlights.

### getFocusableElements(container: HTMLElement): HTMLElement[]

Returns all focusable elements within container.
