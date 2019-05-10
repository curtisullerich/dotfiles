source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle tmuxinator
# Commented this on 2018-04-09 because I think it's causing pastes to take forever. See https://github.com/zsh-users/zsh-syntax-highlighting/issues/295.
# On 2019-05-10 everything seems to be fine, though the ZSH_HIGHLIGHT_STYLES update doesn't work after updating antigen.
antigen bundle zsh-users/zsh-syntax-highlighting
#ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
antigen bundle rupa/z
antigen theme curtisullerich/dotfiles ccu
antigen apply

autoload bashcompinit
bashcompinit
source ~/.bashrc
bindkey '^[OA' history-beginning-search-backward
bindkey '^[OB' history-beginning-search-forward
setopt append_history no_inc_append_history share_history nonomatch

if [ -f ~/.zshrc.google ]; then
  source ~/.zshrc.google
fi
