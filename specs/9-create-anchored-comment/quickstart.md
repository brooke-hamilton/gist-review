# Quickstart: Create Anchored Comment

**Feature**: 9-create-anchored-comment  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-8
- Working OAuth authentication
- Gist with write access for testing

## Implementation Steps

1. **Extend selection popover** with comment form:
   ```html
   <div class="selection-popover" id="selection-popover">
     <div class="selection-info">...</div>
     
     <div class="comment-form" id="comment-form" hidden>
       <div class="form-tabs">
         <button class="tab active" data-tab="edit">Write</button>
         <button class="tab" data-tab="preview">Preview</button>
       </div>
       <div class="tab-content">
         <textarea id="comment-text" placeholder="Leave a comment..."></textarea>
         <div id="comment-preview" class="markdown-content" hidden></div>
       </div>
       <div class="form-actions">
         <button id="cancel-comment">Cancel</button>
         <button id="submit-comment" class="primary">Comment</button>
       </div>
       <div class="form-error" id="form-error" hidden></div>
     </div>
     
     <div class="login-prompt" id="login-prompt" hidden>
       <p>Sign in to comment</p>
       <button id="prompt-login">Sign in with GitHub</button>
     </div>
   </div>
   ```

2. **Implement form logic**:
   - Show form when user has selection
   - Toggle between edit/preview modes
   - Validate non-empty before submit

3. **Build comment with front matter**:
   ```javascript
   function buildCommentBody(selection, revision, file, text) {
     const frontMatter = jsyaml.dump({
       line_start: selection.lineStart,
       line_end: selection.lineEnd,
       offset_start: selection.offsetStart,
       offset_end: selection.offsetEnd,
       selected_text: selection.text,
       revision: revision,
       file: file
     });
     return `---\n${frontMatter}---\n\n${text}`;
   }
   ```

4. **Submit to GitHub API**:
   - POST to `/gists/{id}/comments`
   - Handle success (add to sidebar)
   - Handle errors (show message)

5. **Implement draft preservation**:
   - Save to sessionStorage on auth redirect
   - Restore on page load after auth

6. **Handle unauthenticated users**:
   - Show login prompt instead of form
   - Trigger OAuth flow on click

## Testing

### Happy Path

1. Log in with GitHub
2. Select text in Gist content
3. Enter comment text
4. Click "Comment"
5. Verify comment appears in sidebar
6. Check raw comment on GitHub (verify front matter)

### Error Cases

1. **Empty comment** - Validation prevents submit
2. **API error** - Error message shown, text preserved
3. **Token expired** - Re-auth prompt, draft preserved

### Draft Preservation

1. Enter comment text
2. Click login (if not authed)
3. Complete OAuth flow
4. Verify draft is restored

## Verification Steps

1. Log in and select text
2. Verify form appears in popover
3. Enter comment and preview it
4. Submit and verify success
5. Check comment on GitHub.com
6. Verify front matter is valid YAML

## Success Criteria Checklist

- [ ] Comments appear on GitHub within 5 seconds
- [ ] 100% of comments have valid YAML front matter
- [ ] Front matter contains all selection metadata
- [ ] Login prompt shown for unauthenticated users
- [ ] Drafts preserved during auth flow
- [ ] Empty comments prevented
