# RSpec & Ruby Testing Skill
# Goal: Write fast, deterministic, and readable tests.

## 🏗 Structure
- **Arrange-Act-Assert:** Always follow this pattern. Use whitespace to separate these blocks.
- **Described Class:** Use `expect(described_class).to...` instead of the explicit class name.
- **Let vs Instance Vars:** Use `let` or `let!` exclusively. Never use `@instance_variables` in specs.

## 🎭 Mocking & Doubling
- **Verifying Doubles:** Use `instance_double("ClassName")` instead of `double`.
- **Spy Pattern:** Prefer `expect(obj).to have_received(:method)` (Assert) over `expect(obj).to receive(:method)` (Arrange).

## ⚡️ Performance
- **Minimal Loading:** If a class doesn't require ActiveRecord or ActionController, require `spec_helper` instead of `rails_helper` to skip the Rails boot time.
- **Database Cleanliness:** Use `build` or `build_stubbed` from FactoryBot instead of `create` unless database persistence is strictly required.
