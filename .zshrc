# This loads nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Path to your oh-my-zsh installation.
export ZSH="/home/joao/.oh-my-zsh.sh"

# ZSH_THEME
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git 
zsh-syntax-highlighting
zsh-autosuggestions
zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias py="python3"
alias python="python3"
alias push="git push"
alias v="nvim"
alias c="clear"
alias filmin="xrandr --output HDMI-0 --auto --left-of VGA-0"
alias tvoff="xrandr --output HDMI-0 --off"
alias dot=" ~/dotfiles "
alias get="sudo apt-get install "
alias studio="~/Desktop/android-studio-2020.3.1.26-linux/android-studio/bin/studio.sh" 
alias rmd="rm -rf "
alias up="sudo apt-get update && sudo apt-get upgrade -y"

# Aliases to be used combined
alias sudo="sudo "
alias cd="cd "

alias luamake=/home/joao/dotfiles/lua-language-server/3rd/luamake/luamake
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export EDITOR=nvim
