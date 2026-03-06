# Instructions for AI Agents
User: zmariscal

## 🧠 Core Philosophy
- **High ROI:** Professional, maintainable, and cost-effective solutions.
- **Sandi Metz Rules:** Strict adherence to OOP best practices.
- **Performance First:** Proactively identify bottlenecks and N+1s.
- **Modern Ruby:** Use idiomatic Ruby 3+ syntax.

## 🛠 Executable Commands
When working in this environment, use these commands to verify your work:
- **Run Tests:** `bundle exec rspec`
- **Check Linting:** `bundle exec rubocop` (if present)
- **Setup Environment:** `./scripts/setup`
- **Verify Skills:** `ls -R ~/.claude/skills/`

## 🛠 Skill Discovery
Reference specific rules in `.claude/skills/`:
- `sandi-metz-rules`: Class/method complexity limits.
- `rails-performance`: Database and Sidekiq optimization.
- `rspec-testing`: Fast specs and verifying doubles.
- `modern-ruby`: Style and syntax standards.
- `skill-creator`: How to build new rules for this repo.

## 🚫 Guardrails
- **Never** modify the symlinks in the home directory (`~`) directly. 
- **Always** modify the source file in `~/dotfiles/files/home/` and then run `./scripts/setup`.
