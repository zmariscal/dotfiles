# Dotfiles
export DOTFILES=$HOME/dotfiles

# rv (Ruby Manager)
eval "$(/opt/homebrew/bin/rv shell init zsh)"

export PATH="$HOME/.local/bin:$PATH"

# Oh My Posh
eval "$(/opt/homebrew/bin/oh-my-posh init zsh --config ~/.config/ohmyposh/tokyonight_storm.omp.json)"

# History
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS

# Aliases
alias be="bundle exec"
alias rspec="bundle exec rspec"

# Claude
export CLAUDE_CONFIG_FILE="$HOME/.claude_agent_instructions.md"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
# <<< grok installer <<<

# Completions — after all fpath changes
autoload -Uz compinit
compinit -C

# rv completions need compdef, so they load after compinit
eval "$(/opt/homebrew/bin/rv shell completions zsh)"

# fzf widgets need a real interactive TTY (skip zsh -c / scripts)
if [[ -o interactive && -z $ZSH_EXECUTION_STRING && -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi
