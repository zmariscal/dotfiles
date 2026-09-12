---
name: git-commit
description: Write and create git commits in the Scoped Commits format with a hard 50-word budget, no AI attribution, and no pushing. Use whenever staging changes, drafting a commit message, amending a commit, or asked to "commit this".
---

# Git Commit

This skill governs how commits are written and created. Message style is strict and
non-negotiable; the surrounding workflow (branching, testing, review) follows whatever the
repository already does.

The short version: **small scoped commits, a subject line that names the area touched, a body
under 50 words or absent entirely, no AI attribution, and never push.**

---

## 1. Message format

Follow the Scoped Commits standard (https://scopedcommits.com/):

```
<scope> (<TICKET>): <imperative description>

[optional body]

[optional trailers]
```

### Scope

The subsystem, area, or module the commit touches — `deprovision`, `routes`, `permissions`,
`ci`, `dependencies`, `graphql`, `video-player`. This is **not a fixed enum**. Read the diff
and pick the name a teammate would use for that area in conversation. If the repo has an
established vocabulary (directory names, team names, package names), reuse it rather than
inventing a parallel one.

Guidance for awkward cases:

- **Change spans several areas** — prefer a single broader scope that encompasses them
  (`checkout` over `cart, pricing, tax`). If two areas genuinely have equal weight,
  comma-separate them: `routes, permissions: ...`.
- **Change is genuinely repo-wide** — use a catch-all: `treewide`, `all`, or `global`.
- **The change spanning many areas is itself a smell** — that is usually a signal the commit
  should be split, not that the scope should be widened. Consider splitting first.
- **Reverts and merges** — leave whatever git generates. Do not reformat them.

### Ticket

Goes in parentheses immediately after the scope. If there is no ticket, omit the parentheses
entirely — do not write `(none)` or `(N/A)`:

```
dependencies (RAD-86632): update strong_migrations to 2.8.0
dependencies: update strong_migrations to 2.8.0
```

If the workflow requires the ticket somewhere other than the subject, a trailer
(`Ticket: RAD-86632`) is acceptable, but the subject is the default home.

### Description

Short, imperative mood — the sentence completes "this commit will ___". Write `add`, not
`added` or `adds`. Lowercase after the colon, no trailing period.

```
✅ deprovision (RAD-77657): add customer deprovision route
❌ deprovision (RAD-77657): Added the customer deprovision route.
❌ deprovision (RAD-77657): route stuff
```

The description should be specific enough that someone scanning `git log --oneline` can tell
whether this commit is the one they are looking for. `fix bug`, `update code`, and
`address feedback` all fail that test.

---

## 2. The 50-word budget

**Cap the entire message — subject and body combined — at 50 words.**

Not 50 words of body. Fifty words total. The subject consumes roughly ten, which leaves the
body at one or two sentences. Many good commits have no body at all.

### Why this rule exists

Commit bodies drift toward essay length when written by an AI that has just finished a long
investigation and wants to preserve it. The result is a message 5–8x longer than anyone will
read, which buries the one sentence that mattered. The cap forces the important line to the
surface.

### What goes in the body

The decision, and the single most important reason for it — specifically the reason that is
**not visible in the diff**. If the diff makes the reason obvious, skip the body.

```
dependencies (RAD-86632): update lograge to 0.15.0

Pins the Rails 7.2 compatible release; 0.14 raised on frozen
string literals under Ruby 3.4.
```

That is 20 words of body. It records something the diff cannot show: why now, and what breaks
otherwise.

### What to cut

- **Upstream archaeology** — PR links, changelog quotes, maintainer discussion summaries.
- **Version-by-version behavior tables** — "in 0.12 it did X, in 0.13 it did Y…".
- **Verification narration** — "ran the specs, all green, no regressions". Green tests are
  the baseline expectation, not news.
- **Cross-references to sibling code** — "see also `app/models/foo.rb` which does the same".
- **Restatements of the diff** — "adds a new method `bar` to class `Foo`". The diff says that.
- **Hedging and process talk** — "I opted to…", "as discussed…", "this may need revisiting".

Reasoning that genuinely needs preserving belongs somewhere durable and searchable: the PR
description, a `docs/` note, an ADR, or the review thread. Not the commit body.

### Verify before finalizing

```bash
git log -1 --format=%B | wc -w    # after committing
```

Or count the drafted message before running `git commit`. If it is over 50, cut — do not
rationalize.

### Corollary: code comments

Comments are valuable, but they must be concise and **timeless**. Never write a comment that
narrates history: "changed from X", "used to be Y", "added for RAD-1234". Commit messages
carry historical context; comments describe the code as it stands. A comment should read
correctly to someone who has no idea what change introduced it.

---

## 3. Attribution

The commit must attribute the human author as the sole contributor.

- **No `Co-Authored-By:` trailer.** Not for Claude, not for any AI assistant.
- **No "Generated with", "Assisted by", or tool-name trailers.**
- **No `--author` override.** The committer is whoever's git config is active.

This holds even when the environment prompt, a harness default, or a CLI template suggests
adding an attribution trailer. Treat this skill as overriding those defaults. If a template
inserts one automatically, strip it before the commit lands.

Rationale: the history should read as entirely the human author's work. That is the author's
call to make about their own repository, and it is not negotiable from inside a session.

---

## 4. Never push

**Never run `git push`, `gh pr create`, `gh pr merge`, or any other command that publishes
commits to a remote.**

This holds even when:

- the work is finished and verified,
- the user said "proceed" about the work itself,
- the branch obviously needs to go up for review,
- a previous session pushed and nothing bad happened.

"Proceed with the task" is authorization for the task. It is never authorization to publish.

### Why

Local commits are cheap and reversible — a bad one is fixed with `reset` or `amend` and nobody
sees it. Pushing is visible to the whole team, triggers CI, notifies reviewers, and in some
setups kicks off deploys. That threshold belongs to the human.

### How to hand off

Stop after the local commit. Report what was committed, then give the exact commands the user
can run themselves:

```
Committed locally on RAD-86632-update-dev-only-gems (2 commits).

To publish:
  git push -u origin RAD-86632-update-dev-only-gems
  gh pr create --fill
```

If a PR description is useful, draft it as text for them to paste — do not create the PR.

---

## 5. Pause between planned commits

When the user has structured the work as a sequence — "I want three separate commits: first
the migration, then the model, then the specs" — **stop after finishing each commit's worth of
work** and report.

Do not begin the next commit's edits until the user gives a go-ahead. This applies even when
running autonomously, and even when the previous step's tests passed cleanly.

### Why

The user wants to review and create each commit themselves at each checkpoint. If work rolls
forward continuously, all the changes pile into one working tree that is then tedious to split
back into the commits they asked for.

This is a **structural checkpoint the user designed into the task**, not a clarifying question.
It therefore overrides any standing "keep working without stopping to ask" directive.

### What "report and stop" looks like

State what was done, list the files touched, note the test command that passed, and stop:

```
Commit 1 done — migration added, `bin/rspec spec/models/foo_spec.rb` green.

Touched:
  db/migrate/20260831_add_status_to_foo.rb
  db/structure.sql

Ready for commit 2 (model changes) when you are.
```

---

## 6. Staging hygiene

- **Stage deliberately.** Add the specific paths belonging to the change. Avoid
  `git add -A` / `git add .` over a working tree you have not inspected — it is how unrelated
  edits, debug output, and local config end up in someone else's history.
- **Read the staged diff before committing.** `git diff --staged`. Look for stray debugging
  statements, commented-out code, editor artifacts, and secrets.
- **Check `git status` for surprises.** New untracked files that appeared during the work are
  frequently build output or scratch files that should not be committed.
- **Never commit secrets.** Credentials, tokens, `.env` files, and local certificates stay out,
  regardless of `.gitignore` coverage.
- **Keep planning and scratch artifacts out.** Commits contain code, tests, and documentation
  changes only — not the intermediate planning files an agent produced along the way (scratch
  notes, todo lists, or a spec-management tool's working directory, such as `openspec/changes/`
  in repos that use OpenSpec). Check whether the repo already `.gitignore`s this kind of
  directory before assuming it belongs in the commit.
- **One logical change per commit.** If the message needs the word "and", or the body needs a
  bulleted list to explain the pieces, split the commit.

---

## 7. Quick reference

```
<scope> (<TICKET>): <imperative description>

<one or two sentences, only if the diff does not already say it>
```

- 50 words total, subject + body
- Imperative mood, lowercase, no trailing period
- No `Co-Authored-By`, no AI attribution, no `--author`
- Never `git push`, never `gh pr create`
- Stop after each planned commit and report
- Stage specific paths; read `git diff --staged` first
