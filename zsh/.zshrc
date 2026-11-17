# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# Prompt
autoload -Uz colors && colors
PS1='%F{green}%n@%m%f %F{blue}%~%f %# '

# Keybindings (fix Home/End/Delete)
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# Plugins (if installed via apk)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# --- fzf ---
# Keybindings (Ctrl+R history, Ctrl+T files, Alt+C cd) and completion
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border=sharp --gutter=" " --pointer=" "'

# Optional: use fd and add a preview
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- starship (keep this last) ---
eval "$(starship init zsh)"

fastfetch

#my lazy aliases
dots() {
  git -C ~/dotfiles add -A &&
  git -C ~/dotfiles commit -m "${*:-update}" &&
  git -C ~/dotfiles push
}

# integration of nnn
 export NNN_OPTS='a'
export NNN_PLUG='p:preview-tui;v:popview'
export NNN_PREVIEWIMGPROG=sixel
export TERMINAL=foot
export NNN_TERMINAL=foot
