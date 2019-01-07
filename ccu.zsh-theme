# This belongs in ~/zsh-files/themes/
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

# I used to use these at the end of $descriptive to indicate whether I was in a tmux session or not, but the status bar kinda makes it unnecessary.
myshell=$TERM #so it prints the name by default
case $TERM in
  "screen")
    myshell=∵ #"multiple" because multiplexor
    ;;
  "screen-256color")
    myshell=∵ #"multiple" because multiplexor
    ;;
  "xterm-256color")
    myshell=⠐ #"single" because no multiplexor
    ;;
  "xterm")
    myshell=⠐ #"single" because no multiplexor
    ;;
esac

user_display="$USER@"
case $USER in
  "ccu")
    user_display=""
    ;;
esac

host_display="$HOST"
case $HOST in
  "curtis.mtv.corp.google.com")
    host_display="" # used to be Δ
    ;;
  "ccu-glaptop")
    host_display=δ
    ;;
esac

#descriptive=" $user_display$host_display$myshell "
descriptive=" $user_display$host_display "
if [ "$descriptive" -eq "  " ]; then
  descriptive=" "
fi

PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)%{$fg_bold[green]%}%p %{$fg_no_bold[white]%}%$descriptive%{$fg_bold[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
