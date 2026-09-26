ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light chrissicool/zsh-256color
zinit snippet OMZP::git
zinit snippet OMZP::sudo
autoload -U compinit && compinit
zinit cdreplay -q

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^o' autosuggest-accept
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

HISTSIZE=10000
HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=10000
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto --color=always'
alias la='eza -a1 --icons=auto --color=always'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias nvim="kittypad.sh nvim"
alias glow="kittypad.sh glow"
alias spf="kittypad.sh spf"

export MANPAGER="nvim +Man!"
eval "$(starship init zsh)"
export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
