[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}

complete -F _complete_ssh_hosts ssh

alias ll="ls -ahl"
alias gs="git status"
alias gp="git pull"
alias ge="git edit"
alias gd="git diff"

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
GOPATH=/Users/endregalaczi/.go
export GOPATH
PATH=$PATH:$GOPATH/bin # Add GOPATH/bin to PATH for scripting

HISTSIZE=10000
HISTFILESIZE=20000
DEV_ENV=true


# THis file does not seem to be called
