# Dotfiles
export DOTFILES=$HOME/dotfiles

# 1. Homebrew Setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Zsh Completions (Silent & Secure)
autoload -Uz compinit
compinit -i

# 3. rv (Ruby Manager)
eval "$(/opt/homebrew/bin/rv shell init zsh)"
eval "$(/opt/homebrew/bin/rv shell completions zsh)"

# 4. Oh My Posh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/tokyonight_storm.omp.json)"

export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias be="bundle exec"
alias rspec="bundle exec rspec"

# Claude
export CLAUDE_CONFIG_FILE="$HOME/.claude_agent_instructions.md"
