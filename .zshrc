# 1. Homebrew Setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Zsh Completions (Silent & Secure)
autoload -Uz compinit
# The -i ignores insecure directories to prevent annoying warnings
compinit -i

# 3. rv (Ruby Manager)
eval "$(rv shell init zsh)"
eval "$(rv shell completions zsh)"

# 4. Oh My Posh
eval "$(oh-my-posh init zsh --config ~/dotfiles/tokyonight_storm.omp.json)"
eval "$(/opt/homebrew/bin/rv shell init zsh)"
eval "$(/opt/homebrew/bin/rv shell completions zsh)"
