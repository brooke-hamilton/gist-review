# Quickstart: Text Selection Capture

**Feature**: 8-text-selection-capture  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-7
- Markdown rendering with line mapping

## Implementation Steps

1. **Extend Markdown renderer** to add line attributes:
   - Modify marked.js custom renderer
   - Add `data-line` to block elements
   - Track current line during parsing

2. **Add selection popover HTML**:

   ```html
   <div class="selection-popover" id="selection-popover" hidden>
     <div class="selection-info">
       <span class="selected-text"></span>
       <div class="selection-meta">
         Line: <span class="line-number"></span>
       </div>
     </div>
   </div>
   ```

3. **Add popover CSS**:

   ```css
   .selection-popover {
     position: fixed;
     background: var(--bg-elevated);
     border: 1px solid var(--border);
     border-radius: 4px;
     padding: 8px 12px;
     box-shadow: 0 2px 8px rgba(0,0,0,0.15);
     z-index: 100;
   }
   ```

4. **Implement selection tracking**:
   - Listen for `selectionchange` event
   - Debounce handler (100ms)
   - Extract selection text and range
   - Validate (min 3 chars, not whitespace-only)

5. **Implement line mapping**:
   - Walk DOM tree to find `data-line` attribute
   - Calculate character offsets

6. **Implement popover positioning**:
   - Use `getBoundingClientRect()` for selection
   - Position popover above selection
   - Handle viewport edge cases

## Testing

### Test Scenarios

1. **Single line selection** - Select text on one line
2. **Multi-line selection** - Select across multiple lines
3. **Formatted text** - Select across bold/italic
4. **Code blocks** - Select within code
5. **Short selection** - Less than 3 chars (should not show)
6. **Whitespace only** - Spaces/newlines (should not show)
7. **Clear selection** - Click elsewhere (popover hides)

### Expected Behavior

| Action | Expected Result |
|--------|-----------------|
| Select "hello world" | Popover shows with text and line |
| Select across lines | Shows start and end lines |
| Select 2 characters | No popover |
| Select only spaces | No popover |
| Click elsewhere | Popover hides |

## Verification Steps

1. Load a Gist with multi-paragraph content
2. Select text on various lines
3. Verify popover appears within 200ms
4. Verify line numbers are correct
5. Verify popover disappears when selection clears
6. Test in code blocks and formatted text

## Success Criteria Checklist

- [ ] Selection metadata appears within 200ms
- [ ] Line numbers accurate to source Markdown
- [ ] Character offsets correctly identify position
- [ ] Clear visual feedback when text selected
- [ ] Whitespace-only and short selections ignored
- [ ] Works across element boundaries
