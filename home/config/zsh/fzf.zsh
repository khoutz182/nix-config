
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#$themeColors[color01],bg:#$themeColors[color00],spinner:#$themeColors[color0C],hl:#$themeColors[color0D]"\
" --color=fg:#$themeColors[color04],header:#$themeColors[color0D],info:#$themeColors[color0A],pointer:#$themeColors[color0C]"\
" --color=marker:#$themeColors[color0C],fg+:#$themeColors[color06],prompt:#$themeColors[color0A],hl+:#$themeColors[color0D]"

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
