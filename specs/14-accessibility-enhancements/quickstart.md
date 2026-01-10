# Quickstart: Accessibility Enhancements

**Feature**: 14-accessibility-enhancements  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-13
- Screen reader available for testing (NVDA, VoiceOver)
- axe DevTools browser extension (optional)

## Implementation Steps

1. **Add focus indicator CSS**:

   ```css
   :focus-visible {
     outline: 2px solid #005fcc;
     outline-offset: 2px;
   }
   
   @media (prefers-color-scheme: dark) {
     :focus-visible {
       outline-color: #58a6ff;
     }
   }
   
   /* Screen reader only utility */
   .sr-only {
     position: absolute;
     width: 1px;
     height: 1px;
     padding: 0;
     margin: -1px;
     overflow: hidden;
     clip: rect(0, 0, 0, 0);
     border: 0;
   }
   ```

2. **Add skip link**:

   ```html
   <a href="#main-content" class="skip-link">Skip to content</a>
   <!-- ... -->
   <main id="main-content">
   ```

3. **Add ARIA live regions**:

   ```html
   <div id="status-region" aria-live="polite" aria-atomic="true" class="sr-only"></div>
   <div id="error-region" aria-live="assertive" aria-atomic="true" class="sr-only"></div>
   ```

4. **Add ARIA labels to components**:
   - Revision selector: `aria-label="Select Gist revision"`
   - File tabs: `role="tablist"`, tabs with `role="tab"`
   - Comment sidebar: `aria-label="Gist comments"`
   - Highlights: `role="button"` + descriptive label

5. **Implement focus trapping**:
   - Add to thread panel, OAuth modal, keyboard help
   - Store previous focus element
   - Return focus on close

6. **Make highlights keyboard accessible**:
   - Add `tabindex="0"` to each highlight
   - Handle Enter/Space to activate
   - Add descriptive aria-label

7. **Implement keyboard shortcuts**:
   - Escape: Close any open modal/panel
   - ?: Show keyboard help dialog
   - /: Focus search if present

8. **Create keyboard help dialog**:
   - Modal listing all shortcuts
   - Opened with ?
   - Focus trapped within

## Testing

### Keyboard Navigation Checklist

- [ ] Tab through entire page in logical order
- [ ] All interactive elements reachable
- [ ] Enter/Space activates buttons and links
- [ ] Arrow keys navigate dropdowns
- [ ] Escape closes modals
- [ ] Focus visible on all elements

### Screen Reader Testing

1. **NVDA (Windows)**:
   - Navigate with Tab and arrow keys
   - Verify all elements announced
   - Check live region announcements

2. **VoiceOver (macOS)**:
   - Use VO+arrows to navigate
   - Verify rotor shows landmarks
   - Check form controls labeled

### Automated Testing

1. Install axe DevTools extension
2. Run accessibility scan
3. Fix any critical/serious issues
4. Document known minor issues

## Verification Steps

1. Tab through application without mouse
2. Verify skip link works
3. Test with screen reader
4. Verify focus indicators visible
5. Test Escape to close modals
6. Test ? for keyboard help
7. Run axe accessibility scan

## Success Criteria Checklist

- [ ] 100% elements keyboard navigable
- [ ] Visible focus indicators on all elements
- [ ] Skip link at top of page
- [ ] ARIA labels on all custom components
- [ ] Live regions announce updates
- [ ] Focus trapped in modals
- [ ] Escape closes modals
- [ ] Keyboard help available
- [ ] Passes axe basic tests
- [ ] Works with NVDA/VoiceOver
