# Modern Ruby Style Skill (Ruby 3+)
# Goal: Use concise, idiomatic modern Ruby.

## 💎 Syntax Preferences
- **Pattern Matching:** Use `in` or `case...in` for complex hash/array deconstruction.
- **Endless Methods:** Use `def method_name = ...` for simple one-line methods.
- **Argument Forwarding:** Use `...` to pass all arguments to a super or another method.
- **Symbol to Proc:** Prefer `&.method_name` over blocks for simple iterations.

## 🛡 Performance & Safety
- **Frozen String Literals:** Ensure `# frozen_string_literal: true` is at the top of every file.
- **Memoization:** Use `@result ||= ...` but avoid it if the result could be false/nil (use defined? instead).
