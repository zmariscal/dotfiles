---
name: readability-review
description: Review a Ruby diff against ~/.claude/rules/readability.md before opening or updating a PR. Use before "ready for review", before pushing, or after any reviewer comment about guards or style.
---

# Readability review

Run on `git diff $(git merge-base HEAD main)..HEAD -- '*.rb'`.

1. List every added `&.`, `.strip`, `.presence`, `.blank?`/`.nil?` check, and `count {} >` / `size >` comparison.
2. For each guard, trace the value to its source and write one line: `file:line | value | origin (user / external / our DB) | verdict`. Keep a guard only for user or external input.
3. For each flagged guard, grep the diff, specs included, for siblings of the same pattern. A reviewer comment is one instance of a class, so fix the class.
4. Flag specs that assert behavior only a removed guard provided, such as blank or whitespace input on catalog data.
5. Flag repeated `x&.y` across callers (delegation), `count {}` comparisons (`many?`/`none?`/`one?`), and one-expression helpers (inline).
6. Output the table and the proposed edits. Do not apply them.
