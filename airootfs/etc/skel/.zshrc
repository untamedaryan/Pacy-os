# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Zinit ────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# ── Plugins ──────────────────────────────────────────────
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# ── Powerlevel10k ─────────────────────────────────────────
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── History ───────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups

# ── Zoxide (smart cd) ─────────────────────────────────────
eval "$(zoxide init zsh)"

# ── Aliases ───────────────────────────────────────────────
alias cat='bat --style=auto'
alias cd='z'
alias ..='z ..'
alias ...='z ../..'
alias cls='clear'
alias update='sudo pacman -Syu'
alias yayup='yay -Syu'
alias l='ls -la --color=auto'

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit

# ── Autosuggestion style ──────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7086,italic"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
