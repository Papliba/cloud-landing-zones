---
description: Complete PR workflow - branch, fix, PR, review, iterate, and merge
allowed-tools: Bash(git:*), Bash(gh:*), Edit, Write, Read, Glob, Grep
---

Execute the complete Pull Request workflow for: $ARGUMENTS

## Workflow Steps (Execute ALL automatically):

### 1. Create Feature Branch
- Generate a descriptive branch name based on the task (e.g., `fix/issue-name`, `feat/feature-name`)
- Run `git checkout -b <branch-name>`
- Confirm current branch

### 2. Implement Solution
- Analyze the issue/requirement: $ARGUMENTS
- Make necessary code changes
- Ensure code follows project standards (check CLAUDE.md)

### 3. Commit Changes
- Run `git status` to review changes
- Stage all changes: `git add .`
- Create conventional commit message (fix:/feat:/docs:/refactor:)
- Commit with Claude Code co-author footer

### 4. Push to Feature Branch
- Push branch: `git push -u origin <branch-name>`

### 5. Create Pull Request
- Use `gh pr create` with:
  - Descriptive title summarizing the change
  - Detailed body with Summary and Test plan sections
  - Include Claude Code generation footer

### 6. Self-Review & Add Comments
- Review ALL changed files in the PR
- Use `gh pr view` to see the PR
- Add review comments using `gh pr review` for:
  - Bugs or potential issues
  - Performance concerns
  - Best practice violations
  - Security issues
  - Code quality improvements
  - Missing error handling
  - Unclear logic that needs comments

### 7. Iterative Improvement Loop
**REPEAT until code is perfect:**
- Fix all issues identified in review
- Commit fixes with descriptive messages
- Push to feature branch
- Comment on PR using `gh pr comment` explaining:
  - What was fixed
  - How it was fixed
  - Why the approach was chosen
- Re-review the updated code
- If new issues found, repeat this loop

### 8. Final Merge
- Once NO issues remain and code is perfect:
- Add final approval comment
- Merge PR: `gh pr merge --merge` (or --squash if preferred)
- Delete feature branch: `git branch -d <branch-name>`
- Switch back to main: `git checkout main`
- Pull latest: `git pull origin main`

## Important Notes
- NEVER push directly to main
- Be thorough in reviews - look for real issues
- Don't merge until truly perfect
- Document all fixes in PR comments
- Complete the entire workflow automatically
