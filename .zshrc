alias please="sudo"
alias pwease="sudo"
alias uwu="sudo"
alias owo="sudo"

xrandr() {
  /usr/bin/xrandr "$@"
  nitrogen --set-centered ~/Wallpaper.png
}

eval "$(starship init zsh)"
