# zmariscal/dotfiles

Personal development environment and AI agent directives optimized for **Ruby on Rails performance**, **high-ROI DIY workflows**, and **Sandi Metz's OOP principles**.

This repository uses a **mirror structure**. Everything in `files/home/` is symlinked to the user's home directory (`~`).

## 🧠 Philosophy

1. **AI as a Peer:** My AI agents (Claude Code) are instructed to be opinionated and strict. They follow a specific set of skills that prioritize long-term maintainability over quick hacks.
2. **Performance First:** Code that isn't fast isn't finished. This environment enforces N+1 detection and efficient ActiveRecord patterns.
3. **High ROI:** Tools and configurations should be professional-grade but cost-effective and easy to maintain.

## 🏗 Structure

- `AGENTS.md`: The master directive for AI agents.
- `files/home/`: Mirror of the home directory (contains `.zshrc`, `.irbrc`, etc.).
- `.claude/skills/`: Domain-specific rulebooks for AI agents.
- `scripts/setup`: The engine that links this repo to the system.



## 🛠 AI Skills Included

- **Sandi Metz Rules**: Enforcing class and method size limits.
- **Rails Performance**: Optimization for database queries and Sidekiq jobs.
- **RSpec Testing**: Modern mocking (verifying doubles) and speed-focused spec suites.
- **Modern Ruby**: Idiomatic use of Ruby 3+ (Pattern matching, endless methods).
- **Skill Creator**: A meta-skill for generating new instructions for this repo.

## 🚀 Installation

```bash
git clone https://github.com/zmariscal/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/setup
```

## 💎 Ruby Workflow

- **IRB**: Pre-configured with history and simplified prompts.
- **Shell**: Optimized aliases for `bundle exec` and `rspec`.
- **Environment**: Global `CLAUDE_CONFIG_FILE` pointer for seamless AI integration.

---
Built by [zmariscal](https://github.com/zmariscal) 
