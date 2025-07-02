setopt histignorealldups sharehistory

bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

autoload -Uz up-line-or-search
autoload -Uz down-line-or-search

export TERM=xterm-256color

if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi
eval "$(starship init zsh)"

alias vim=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
