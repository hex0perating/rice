alias please="sudo"
alias pwease="sudo"
alias uwu="sudo"
alias owo="sudo"

alias vim="nvim"
alias emacs="nvim"
alias vi="nvim"

alias yay="hexpm aur"
alias paru="hexpm aur"

xrandr() {
  /usr/bin/xrandr "$@"
  nitrogen --set-centered ~/Wallpaper.png
}

eval "$(starship init zsh)"
