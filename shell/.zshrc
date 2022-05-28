# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source global definitions
if [ -f /etc/zshrc ]; then
        . /etc/zshrc
fi

HISTFILE=~/.cache/zsh_history
HISTSIZE=10000 # per session
SAVEHIST=100000 # in file
setopt appendhistory

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH 

source ~/.zshrc-personal

# Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^?" backward-delete-char # backspace fix

# tab through options
autoload -U compinit && compinit
zstyle ':completion:*' menu select

export EDITOR=nvim
alias v="$EDITOR"
alias vim="$EDITOR"

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
alias fm='lfcd'
source ~/.config/lf/icons.sh
export LS_COLORS='ow=36:di=34:fi=0:ex=31:ln=35'

alias s='source'
# alias ls='ls --color=auto'
alias ls='ptls'
alias l='ls'
alias ll='ls -alh'
alias cd..='cd ..'
alias ..='cd ..'


alias nvimrc="$EDITOR ~/.config/nvim/init.vim"
alias lfrc="$EDITOR ~/.config/lf/lfrc"
alias bsprc="$EDITOR ~/.config/bspwm/bspwmrc"
alias skrc="$EDITOR ~/.config/sxhkd/sxhkdrc"
alias ala="$EDITOR ~/.config/alacritty/alacritty.yml"
alias kit="$EDITOR ~/.config/kitty/kitty.conf"
alias ozh="$EDITOR ~/.zshrc"

# colours
# if command -v theme.sh > /dev/null; then
#   [ -e ~/.theme_history ] && theme.sh "$(theme.sh -l|tail -n1)"
#
#   # Optional
#
#   #Binds C-o to the previously active theme.
#   # bind -x '"\C-o":"theme.sh $(theme.sh -l|tail -n2|head -n1)"'
#
#   alias th='theme.sh -i'
#
#   # Interactively load a light theme
#   alias thl='theme.sh --light -i'
#
#   # Interactively load a dark theme
#   alias thd='theme.sh --dark -i'
# fi

# using pywal
# cat ~/.cache/wal/sequences

alias wr=~/wallpapers/random_wallpaper_linux.sh

# use terminal transparency
alias fzf='fzf --color "bg:-1"'
# fzf for scrolling through history, if installed
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

gitall() {
  git pull # just in case
  git add .
  git commit
  git push
}

mkcd() {
  mkdir -p $1 
  cd $1
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

pymol(){
/usr/bin/pymol $@ -d "@~/.config/pymol/pymolrc"
}

export st=~/Documents/src-code/st

export GOPATH=$HOME/go
export PATH=$HOME/go/bin:$PATH

# export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
# eval "$(starship init zsh)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
