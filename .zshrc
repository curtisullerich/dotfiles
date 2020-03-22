# to profile zsh startup time, uncomment lines 2 and -1
# zmodload zsh/zprof

# source ~/antigen.zsh
# antigen bundle robbyrussell/oh-my-zsh lib/
# # Commented this on 2018-04-09 because I think it's causing pastes to take forever. See https://github.com/zsh-users/zsh-syntax-highlighting/issues/295.
# # On 2019-05-10 everything seems to be fine, though the ZSH_HIGHLIGHT_STYLES update doesn't work after updating antigen.
# antigen bundle zsh-users/zsh-syntax-highlighting
# # zdharma/fast-syntax-highlighting may be an alternative worth trying
# antigen bundle zsh-users/zsh-autosuggestions
# #ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
# antigen bundle rupa/z
# # expected to be in ~/zsh-files/themes/ccu.zsh-theme
# # antigen theme ~/zsh-files themes/ccu --no-local-clone
# antigen theme XsErG/zsh-themes themes/lazyuser
# antigen apply

# antibody installed with `curl -sfL git.io/antibody | sh -s - -b ~/bin`
# update plugins with `antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh`

# to see how a segment takes, put `timestart` before it and `timestop <foo>` after it to print.
function timestart() {
  START=$(date +%s%N)
}
function timestop() {
  local start=$START
  local comment=$1
  local now=$(date +%s%N)
  echo took $(( $(( $now - $start )) / 1000000)) milliseconds for $comment
}

source ~/.zsh_plugins.sh

# from gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  echo "running compinit"
  compinit;
else
  compinit -C;
fi;

function hg-hint-cp() {
  hg uncommit --keep $2
  hg forget $2
  hg cp --after $1 $2
  hg stat
}

# I'm really not sure when bashcompinit needs to be run, if ever. I had it scattered in a few places.
# autoload bashcompinit
# bashcompinit
source ~/.bashrc
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward
setopt append_history no_inc_append_history share_history nonomatch

# Enables fzf. install with `sudo apt install fzf`
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# zprof
