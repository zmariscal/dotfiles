---
paths:
  - "spec/**"
  - "test/**"
---

# Testing

- Use RSpec. Test behavior, not implementation. Never test a private method. Never stub the system under test.
- Code serves the product, not the tests. Never change behavior or add indirection only to make something testable.
- Write the failing spec first (Red-Green-Refactor).
- Write model and component specs as unit specs, and controller specs as request specs.

## Structure

- Arrange-Act-Assert, separated by whitespace.
- Perform setup inside the example. Replace `let`, `let!` and `before` with inline code or a shared helper method called within the example. Never use `@instance_variables`.
- Use `described_class`, not the literal class name.

## Doubles

- Use `instance_double`, never a bare `double`.
- Prefer `expect(obj).to have_received(:method)` over `expect(obj).to receive(:method)`.

## Performance

- If a class doesn't need ActiveRecord or ActionController, require `spec_helper`, not `rails_helper`.
- Use FactoryBot `build` or `build_stubbed` over `create` unless the test needs the row in the database.
- A base factory defines the minimum valid state. Use traits for composable aspects.

## Models

- State an association, enum, normalization, column default, or built-in validation with a shoulda-matchers one-liner. Write an example for the rest, such as a custom validator, callback, or method.
