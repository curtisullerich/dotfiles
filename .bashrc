# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# shopt -s histappend # in bash
# setopt histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000000
HISTFILESIZE=200000000
SAVEHIST=100000000


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# used in bash, maybe not necessary in zsh
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ false ]; then # breaks zsh prompt
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
    else
  color_prompt=
    fi
fi
function timer {
  counter=0
  limit=$1
  summary=$2
  startmessage=$3
  endmessage=$4
  #notify-send -u critical -i appointment -t 600 "$summary" "$startmessage"
  while [ $counter != $limit ]; do
    echo -en "\r\e[K$counter minutes so far...";
    sleep 60
    let "counter = $counter + 1"
  done
  if [ $counter = $limit ]; then
    notify-send -u critical -i appointment "$summary" "$endmessage"
    echo -e '\a' <&2
    return
  fi
}

red_bg=$(tput setab 1)
bold=$(tput bold)
blue=$(tput setaf 4)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
plain_text=$(tput sgr0)
black_bg=$(tput setab 0)
magenta=$(tput setaf 5)

if [ $SHELL = "/bin/bash" ]; then
  source ~/.git-prompt.sh
  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[$bold\]\[$green\]\u@\h\[$plain_text\]:\[$bold\]\[$blue\]'"${PWD}"'\[$magenta\]$(__git_ps1)\[$plain_text\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
fi
unset color_prompt force_color_prompt

# uncommented in zsh migration. this breaks the prompt in non-byobu shells.
# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


PAGER=less; export PAGER

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
if [ -f ~/.aliases.local ]; then
    . ~/.aliases.local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# disabled during zsh migration
# if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#     . /etc/bash_completion
# fi


# notify after long-running command finish
al(){
    start=$(date +%s)
    "$@"
    [ $(($(date +%s) - start)) -le 15 ] || notify-send "Notification" "\"$(echo $@)\" took $(($(date +%s) - start)) seconds to finish"
}

export EDITOR="vim"

function last_was_blank {
  local last_command="$(history 1)"
  if [[ "$last_was_blank_PREVIOUS_LINE" = "$last_command" ]] ; then
    export last_was_blank_PREVIOUS_LINE="$last_command"
    return 0
  else
    export last_was_blank_PREVIOUS_LINE="$last_command"
    return 1
  fi
}

function last_was_blank_2 {
  local HISTCMD_previous="$(fc -l -1)"
  #echo "HISTCMD_previous: $HISTCMD_previous"
  HISTCMD_previous="${HISTCMD_previous%%[\t ]*}"
  #echo "HISTCMD_previous: $HISTCMD_previous"
  if [[ -z "$HISTCMD_before_last" ]]; then
    HISTCMD_before_last="$HISTCMD_previous"
    #printf "initial prompt"
    return 1
  elif [[ "$HISTCMD_before_last" = "$HISTCMD_previous" ]]; then
    HISTCMD_before_last="$HISTCMD_previous"
    #printf "cancelled prompt"
    return 0
  else
    HISTCMD_before_last="$HISTCMD_previous"
    #printf "a command was run"
    return 1
  fi
}
#PROMPT_COMMAND=last_was_blank

function set_window_from_return_code {
  local bg_color=$([ $? == 0 ] && echo "green" || echo "red")
  #echo "$(last_was_blank_2)"
  if last_was_blank_2 ; then
    bg_color="default"
  fi
  #echo "setting to $bg_color"
  tmux set-window-option -t${TMUX_PANE} window-status-bg $bg_color &> /dev/null
}

if [ false ]; then #breaks zsh prompt
#export HISTCONTROL=""
# The beginnings of getting tmux to set the current pane's status color based on the previous command's return value
#PROMPT_COMMAND="tmux set-window-option -t${TMUX_PANE} window-status-bg blue"
PROMPT_COMMAND='set_window_from_return_code && LAST="`cat /tmp/x`"; exec >/dev/tty; exec > >(tee /tmp/x)'
fi

#disabled in zsh migration
#bind '"\C-H":backward-kill-word'

if [ -f ~/.bashrc.google ]; then
  source ~/.bashrc.google
fi
