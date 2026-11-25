# Ruby Readability

- Before adding a guard (`&.`, `strip`, `presence`, nil checks), trace where the value comes from. Defend only values a user types or an external system sends, never what our own importer or database has already cleaned.
- Do not add a normalization or a trim until you have found the boundary that should own it. Ask whether it belongs there, or whether nothing needs it at all.
- Prefer the Enumerable or ActiveSupport predicate over a count comparison: `many?`, `none?`, `one?`, `any?`. Write `many? { }`, not `count { } > 1`.
- Prefer a delegation (`delegate :x, to: :y, allow_nil: true`) over `it.y&.x` repeated across callers.
- Inline a helper that only wraps one expression.
- When a reviewer asks "why do we need this?", answer from the traced data flow, not from the spec. Check whether the spec itself overreaches.
