# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

# alias cp='cp -i'
# alias rm='rm -i'
# alias mv='mv -i'
alias rm="mv -f --backup=numbered --target-directory ~/.Trash"
alias la="ls -lA"

export PATH=~/bin:$PATH
# [ -n "${BASH_COMPLETION}" ] || \
#      export BASH_COMPLETION="$HOME/.bash_completion" . $BASH_COMPLETION

#if [ -f ~/.bash_completion ]; then
#   . ~/.bash_completion

# history
HISTTIMEFORMAT='%y/%m/%d %H:%M:%S ';
