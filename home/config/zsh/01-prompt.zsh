
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
# zstyle ':vcs_info:git*' formats "%f(%F{#$themeColors[color0A]}%b%f)" 
zstyle ':vcs_info:git*' formats "%f(%F{#$themeColors[color0C]}%b%F{#$themeColors[color08]}%u%F{#$themeColors[color0B]}%c%f) %a"

precmd() {
    vcs_info
}

# Must be single quoted strings for substitution to work
setopt prompt_subst
PROMPT='%F{#$themeColors[color0D]}%~%f ${vcs_info_msg_0_} %(?..%F{#$themeColors[color08]}[%?])
%F{#$themeColors[color0A]}❯%f '

# load it up right away
znap prompt

