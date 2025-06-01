# Aliases
# alias zrl="source ~/.zshrc"
# alias sxiv="sxiv -r -t -p"
# alias vim="nvim"
# alias ls="exa"
# alias l="exa -lh"
# alias la="exa -ah"
# alias ll="exa -l"
# alias lla="exa -lah"
# alias mnt="ecryptfs-mount-private"
# alias umnt="ecryptfs-umount-private"
# alias man="batman"

# EWW
alias eww="eww --config $EWW_CONFIG_DIR"

# mac emulation
# alias pbcopy="xsel --clipboard --input"
# alias pbpaste="xsel --clipboard --output"

# logout
alias log-out="loginctl kill-session $XDG_SESSION_ID"

# Docker helpers
alias dc='docker-compose'

# kubeseal quick hack
# alias kubeseal='kubeseal --controller-namespace infra-sealed-secrets --controller-name infrastructure-sealed-secrets -o yaml'

alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..

# Git

# CLI diff tool
# alias vimdiff='nvim -d'

# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}
# alias g='git'
#
# alias ga='git add'
# alias gaa='git add --all'
# alias gapa='git add --patch'
# alias gau='git add --update'
# alias gav='git add --verbose'
#
# alias gb='git branch'
# alias gbl='git blame -b -w'
# alias gbnm='git branch --no-merged'
# alias gbr='git branch --remote'
# alias gst='git status'
#
# alias gc='git commit -v'
# alias gca='git commit -v -a'
#
# alias gwt='git worktree'
#
# alias gclean='git clean -id'
# alias gr='git restore'
# alias grs='git restore --staged'
# alias gpristine='git reset --hard && git clean -dffx'
# alias gcm='git checkout $(git_main_branch)'
# alias gcb='git checkout -b'
# alias gco='git checkout'
# alias gcp='git cherry-pick'
# alias gcpa='git cherry-pick --abort'
# alias gcpc='git cherry-pick --continue'
#
# alias gd='git diff'
# alias gdca='git diff --cached'
# alias gdcw='git diff --cached --word-diff'
# alias gds='git diff --staged'
# alias gdt='git diff-tree --no-commit-id --name-only -r'
# alias gdup='git diff @{upstream}'
# alias gdw='git diff --word-diff'
# alias gdss='git diff --shortstat'
#
# alias gri='git rebase -i'
# alias grim='git rebase -i $(git_main_branch)'
#
# alias groh='git reset origin/$(git_current_branch) --hard'
#
# alias ggpull='git pull origin "$(git_current_branch)"'
# alias ggpush='git push origin "$(git_current_branch)"'
#
# alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
# alias gpsup='git push --set-upstream origin $(git_current_branch)'
# alias gpull='git pull --prune'
# alias glg='git log --stat'
# alias glgp='git log --stat -p'
# alias glgg='git log --graph'
# alias glgga='git log --graph --decorate --all'
# alias glgm='git log --graph --max-count=10'
# alias glo='git log --oneline --decorate'
# alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'    "
# alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset    ' --stat"
# alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'    "
# alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset    ' --date=short"
# alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset    ' --all"
# alias glog='git log --oneline --decorate --graph'
# alias gloga='git log --oneline --decorate --graph --all'
#
# # Disable correction
# alias cd='nocorrect cd'
# alias cp='nocorrect cp'
# alias grep='nocorrect grep'
# alias rg='nocorrect rg'
# alias z='nocorrect z'
# alias mv='nocorrect mv'

# download youtubes
alias ytd='yt-dlp "$(pbpaste)"'

# Spotify cli
alias spt='spotify_player'

# homebrew aliases
alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'
