# Set path if required
#export GOPATH=$HOME/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
export ZSH="$HOME/.oh-my-zsh/"
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
git
debian
docker
zsh-autosuggestions
zsh-syntax-highlighting
golang
eza
battery
docker-compose

)
source   $ZSH/oh-my-zsh.sh
#POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


zinit light Aloxaf/fzf-tab

source $HOME/.alias
source ~/.profile
source ~/.p10k.zsh

#source <(fzf --zsh)
#neofetch

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

