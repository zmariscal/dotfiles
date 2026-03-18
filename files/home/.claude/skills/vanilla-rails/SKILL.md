# Vanilla Rails Skill

## Goal

Help zmariscal build and maintain conventional Ruby on Rails applications using Rails defaults, RESTful design, rich domain models, and clear, readable Ruby. Favor solutions that fit naturally within a standard Rails codebase and are a pleasure to read and maintain.

## Philosophy

- Prefer Rails conventions over custom abstractions.
- Favor a vanilla Rails approach: thin controllers directly invoking a rich domain model.
- Optimize for readability, maintainability, and developer ergonomics.
- Keep code close to the domain and easy to trace.
- Default to the simplest solution that works well in a conventional Rails app.
- Write code that reads clearly top-to-bottom and feels intentional.

## General Approach

- Follow existing project conventions before proposing new ones.
- Prefer small, targeted changes over broad refactors.
- When suggesting code, make it idiomatic Ruby and Rails.
- Preserve backwards compatibility unless the task explicitly allows breaking changes.
- Call out tradeoffs when there is more than one reasonable approach.
- Prefer concrete, conventional file placements and APIs over framework-like internal abstractions.

## Ruby Style

- Prefer readability over cleverness.
- In general, prefer expanded conditionals over guard clauses when that makes the flow easier to read.
- Use early returns sparingly, mainly when they appear at the top of a method and make a longer method easier to understand.
- Order methods clearly:
  - class methods first
  - public methods next, with `initialize` first when present
  - private methods last
- Order methods vertically by invocation flow when practical, so readers can follow execution top-to-bottom.
- Do not use `!` merely to signal that a method changes state.
- Prefer `!` only when there is a meaningful non-bang counterpart.
- For classes, do not add a blank line under `private` or other visibility modifiers, and indent methods beneath them if that matches the style being followed.
- Keep methods focused and reasonably small.

## Application Structure

- Prefer standard Rails directories and naming conventions.
- Keep controllers thin and focused on HTTP concerns.
- Put business behavior in models when it naturally belongs to the domain.
- Only introduce additional objects when they make the code simpler or clearer.
- Avoid creating layers by default.

## Controllers

- Keep controllers responsible for params, authorization, response handling, and orchestration.
- Avoid placing business logic directly in controller actions.
- Prefer controllers that directly call expressive model methods.
- It is fine for controllers to invoke Active Record operations directly when the behavior is straightforward.
- Use strong parameters.
- Prefer RESTful routes and actions.

## Domain Models

- Favor rich domain models with intention-revealing APIs.
- Prefer model methods like `gild`, `publish`, `archive`, or `cancel` over pushing business workflows into controller code.
- Keep domain behavior near the records and relationships it operates on.
- Use plain Active Record naturally instead of wrapping basic persistence in extra layers.

## Service Objects and Form Objects

- Do not introduce service objects by default.
- Prefer vanilla Rails with thin controllers and rich models.
- Use a service object or form object only when it is clearly justified by complexity or boundary concerns.
- When used, treat it as a practical object, not a privileged architectural pattern.
- Avoid creating service objects for simple CRUD or basic domain operations.

## Active Record

- Prefer expressive Active Record queries over raw SQL unless SQL is clearly needed.
- Use scopes for reusable query logic when they remain simple and composable.
- Keep callbacks minimal and predictable.
- Favor explicit associations, validations, and database constraints.
- When changing data behavior, consider indexes, nullability, foreign keys, and default values.
- Be careful with N+1 queries; use `includes`, `preload`, or `eager_load` intentionally.

## Routing and Resources

- Prefer resourceful routing.
- Model web endpoints as CRUD operations on resources.
- When an action does not map cleanly to a standard CRUD verb, prefer introducing a new resource over adding custom ad hoc actions.
- Keep routes readable and unsurprising.

## Views

- Use Rails view conventions and partials for shared UI fragments.
- Keep views simple and presentation-focused.
- Avoid embedding complex business logic in templates.
- Prefer built-in Rails helpers before introducing custom presentation abstractions.

## Background Jobs

- Write shallow job classes that delegate real work to domain models or domain objects.
- Keep jobs small, idempotent, and focused on async orchestration.
- Prefer passing records or IDs in the way the app already does consistently.
- Consider `_later` for methods that enqueue jobs and `_now` for corresponding synchronous work when that naming pattern improves clarity.

## Migrations

- Write reversible migrations when practical.
- Prefer safe, incremental schema changes.
- Consider production impact for large tables and long-running operations.
- Add indexes intentionally and verify they support real query patterns.
- Avoid mixing schema changes and large data backfills in one migration unless it is clearly safe.

## Testing

- Prefer the project's existing test framework and conventions.
- Test behavior, not implementation details.
- Favor request specs, model specs, and system specs where appropriate.
- Add regression coverage for bugs before fixing them when possible.
- Avoid excessive mocking in Rails app code unless isolation is necessary.
- Prefer tests that exercise the domain model and real application flow over tests that mirror internal abstractions.

## Performance

- Start with the simplest implementation, then optimize based on evidence.
- Watch for N+1 queries, unnecessary allocations, and repeated database access.
- Prefer app-level clarity over premature optimization.
- When optimizing, explain why the change helps and what tradeoffs it introduces.

## Dependencies

- Prefer built-in Rails features before adding gems.
- Recommend new gems only when they provide clear ongoing value.
- Minimize dependency surface area in conventional applications.

## Security

- Use Rails defaults for CSRF, parameter filtering, and escaping unless requirements differ.
- Be careful with mass assignment, unsafe SQL, and user-provided input.
- Consider authorization and authentication impact when proposing controller or model changes.
- Do not expose secrets or recommend insecure shortcuts.

## When Helping

- Provide code that fits naturally into a conventional Rails app.
- Mention file paths when suggesting changes.
- Explain where code belongs and why.
- Recommend the most conventional Rails approach first.
- Prefer rich domain models over service layers by default.
- Prefer RESTful resources over custom controller actions.
- Prefer shallow jobs that call domain behavior instead of embedding business logic in jobs.
- For upgrades or refactors, suggest incremental migration paths instead of all-at-once rewrites.
