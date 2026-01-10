# Quickstart: Visual Comment Anchoring

**Feature**: 10-visual-comment-anchoring  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-9
- Gists with anchored comments

## Implementation Steps

1. **Add highlight CSS**:
   ```css
   /* Modern browsers */
   ::highlight(comment-anchor) {
     background-color: rgba(255, 213, 79, 0.4);
   }
   
   /* Fallback for older browsers */
   .comment-highlight {
     background-color: rgba(255, 213, 79, 0.4);
     cursor: pointer;
     border-radius: 2px;
   }
   
   .comment-highlight:hover {
     background-color: rgba(255, 213, 79, 0.6);
   }
   
   /* Orphaned comment in sidebar */
   .comment-card.orphaned {
     opacity: 0.7;
     border-left: 3px solid var(--warning-color);
   }
   
   .comment-card.orphaned::before {
     content: "⚠️";
     margin-right: 8px;
   }
   ```

2. **Implement highlight rendering**:
   - Filter comments by current revision
   - For each anchored comment:
     - Find DOM position using line/offset
     - Create Range object
     - Apply highlight with comment ID data

3. **Implement click handling**:
   - Add event listener on content area
   - Detect clicks on highlights
   - For single comment: focus in sidebar
   - For multiple: show selector popup

4. **Implement orphan detection**:
   - Try to find anchor position
   - If not found, mark as orphaned
   - Display with warning in sidebar

5. **Handle revision changes**:
   - Clear existing highlights
   - Re-render for new revision
   - Update orphan status

## Testing

### Test Scenarios

1. **Single comment highlight** - One comment on text region
2. **Multiple comments same region** - Overlapping anchors
3. **Click to focus** - Click highlight, verify sidebar scrolls
4. **Revision switch** - Change revision, verify highlights update
5. **Orphaned comment** - Comment on deleted text
6. **Hover effect** - Darker background on hover

### Create Test Data

1. Create a Gist with multiple lines
2. Add comments via the app on different selections
3. Edit the Gist on GitHub to remove some anchored text
4. Create new revision
5. Test highlighting on both revisions

## Verification Steps

1. Load Gist with anchored comments
2. Verify highlights appear on anchored text
3. Hover over highlight, verify darker background
4. Click highlight, verify sidebar scrolls to comment
5. Switch revisions, verify highlights update
6. Check orphaned comments show warning

## Success Criteria Checklist

- [ ] Highlights render within 1 second of content display
- [ ] All comments for current revision have highlights
- [ ] Clicking highlight focuses comment within 500ms
- [ ] Switching revisions updates highlights within 1 second
- [ ] Orphaned comments show warning icon
- [ ] Overlapping anchors show selection popup
