---
name: scoped-commits
description: Use when writing git commit messages (git commit, drafting a commit, PR title conventions). Formats messages as "<scope>: <description>" per the Scoped Commits convention (scopedcommits.com) instead of Conventional Commits' "type(scope):" style. Use when the user mentions "scoped commits", asks for scope-first commit messages, or when a repo's history already follows this pattern.
---

# Scoped Commits

## Core format

```
<scope>: <description>

[optional body]

[optional trailer(s)]
```

- **scope** — the subsystem, area, or module the commit touches (a directory, package, component, or subsystem name), not a change-type label like `feat`/`fix`. There is no fixed vocabulary of scopes — this is not Conventional Commits with the type/scope swapped; the scope names something specific to the codebase.
- **description** — brief, imperative summary of what changed.
- Body and trailers are optional, same as any git commit.

## Choosing the scope

Derive the scope from what the diff actually touches, in this order of preference:

1. **Check repo history first** — run `git log --oneline -20` (or `git log --oneline -- <changed path>`) to see what scope names this project already uses for the affected area. Reuse them exactly; don't invent a synonym.
2. If no precedent exists, use the most specific meaningful unit: a top-level directory, package, module, or component name (e.g. `auth`, `api/users`, `xwayland`, `net/http/cookiejar`).
3. **Multiple areas in one commit** — pick one:
   - A broader scope that honestly covers all touched areas.
   - Comma-separated scopes (`auth,billing:`).
   - `treewide`, `all`, or `global` for genuinely tree-wide changes (formatting, dependency bumps, license headers).
   - If the areas are unrelated, that's usually a sign the commit should be split instead of scoped broadly — split first if reasonable.
4. **Nothing sensible to scope** (e.g. a one-off repo-root file) — omit the scope rather than force one; write a plain description.

## Ticket numbers

Put them in parentheses after the scope, or in the body/trailer — whichever this project already does:

```
auth (PROJ-123): reject expired refresh tokens
```

## Special commits

Reverts, merges, and other mechanical commits aren't bound to this format — use `git revert`'s default message, the merge tool's default, or whatever the team already does for these.

## Examples

```
i2c: virtio: mark device ready before registering the adapter
gitlab-ci: update macOS image
net/http/cookiejar: add godoc links
xwayland: 24.1.11 -> 24.1.12
auth: reject expired refresh tokens
treewide: bump minimum Go version to 1.22
```

## When drafting a commit in this repo

1. `git log --oneline -10` to confirm this repo actually uses scoped commits (and to learn its scope vocabulary and casing/tense conventions) before applying this format — don't impose it on a repo that follows a different convention (e.g. Conventional Commits) unless the user asks you to switch.
2. Pick the scope per the rules above.
3. Write the description in the same mood/case/tense the repo's recent history uses (commonly imperative, lowercase after the colon).
4. Follow the rest of the standard commit workflow (review staged diff, don't commit unless asked, etc.) as normal.
