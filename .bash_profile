export EDITOR=vi
export CLICOLOR=1
##############################
# Git Commands
#############################
    RED="\[\033[0;31m\]"
    YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
    BLUE="\[\033[0;34m\]"
    LIGHT_RED="\[\033[1;31m\]"
    LIGHT_GREEN="\[\033[1;32m\]"
    WHITE="\[\033[1;37m\]"
    LIGHT_GRAY="\[\033[0;37m\]"
    PURPLE="\[\033[0;35m\]"
    CYAN="\[\033[0;36m\]"
    COLOR_NONE="\[\e[0m\]"

source ~/.git-completion.bash
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
# use legacy to show expected upstream states; look into why later
GIT_PS1_SHOWUPSTREAM="auto legacy"
GIT_PS1_DESCRIBE_STYLE="default"
#GIT_PS1_SHOWCOLORHINTS=true

my_git_status() {
    statusColor=""
    if [[ $(__git_ps1) =~ [\*|\>] ]]
    # a file has been modified but not added and/or branch is ahead of the remote (push recommended)
    then statusColor="$YELLOW"
    elif [[ $(__git_ps1) =~ [\+|\<] ]]
    # a file has been added, but not committed and/or branch is behind the remote (pull recommended)
    then statusColor="$LIGHT_RED"
    # the state is clean, changes are committed and/or branch is in sync with the remote
    else statusColor="$GREEN"
    fi

    echo $statusColor$(__git_ps1 " (%s)")
}

function prompt_func() {
   previous_return_value=$?;
   #The lowercase w is the full current working directory
   prompt="\n${TITLEBAR}${BLUE}[${GREEN}\u@\H${BLUE}]${COLOR_NONE}\n${BLUE}[${LIGHT_RED}\w${BLUE}$(my_git_status)${BLUE}]${COLOR_NONE}"
   
   #Capital W is just the trailing part of the current working directory
   #prompt="${TITLEBAR}${BLUE}[${RED}\W${GREEN}$(my_git_status)${BLUE}]${COLOR_NONE}"
   
   if test $previous_return_value -eq 0
   then
       PS1="${prompt}\n\$${COLOR_NONE} "
   else
       PS1="${prompt}${RED}\n\$${COLOR_NONE} "
   fi
}

PROMPT_COMMAND="prompt_func;$PROMPT_COMMAND"

alias mkdir='mkdir -p'
alias cp='cp -v'
alias cpr='cp -rv'
alias rmr='rm -rv'
alias rm='rm -v'
alias dirsynclink='rsync --verbose --recursive --times --compress --stats --progress --human-readable --copy-links --copy-dirlinks --update'
alias dirsyncnolink='rsync --verbose --recursive --times --compress --stats --progress --human-readable --no-links --update'
alias dirsync='rsync --verbose --recursive --times --compress --stats --progress --human-readable --links --hard-links'
alias rsyncnt='rsync --verbose --recursive --compress --stats --progress --human-readable --copy-links --copy-dirlinks --update'
alias rsync='rsync --verbose --progress --human-readable'
alias duh='dulist=$(du -sh */); for i in T G M K; do printf "$dulist"|egrep "^[0-9\.]+$i" | sort -rn; done'
alias ll='ls -hal'
alias gitl='git log --stat'
alias pong='ping -c2'

# see https://getcomposer.org/xdebug for reasoning behind aliases below
# Load xdebug Zend extension with php command
#alias php='php -dzend_extension="/usr/local/opt/php56-xdebug/xdebug.so"'
# PHPUnit needs xdebug for coverage. In this case, just make an alias with php command prefix.
#alias phpunit='php $(which phpunit)'

function fun_history {
   # history|awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}'|sort -rn|head
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head
}

alias hist=fun_history

alias now='date +%Y%m%d%H%M%S'
alias d1='cd /Volumes/alice/projects/bburro/d1app'
alias cb='cd /Volumes/alice/projects/bburro/casebox'
alias jfo='cd /Volumes/alice/projects/bburro/jfo'
alias smr='cd /Volumes/alice/projects/bburro/smrconnect'
alias resume='cd /Volumes/alice/projects/mine/resume'

# editted for homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
#export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
#export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"

# export for phpstorm debugging
export XDEBUG_CONFIG="idekey=PHPSTORM"
#export PHP_IDE_CONFIG="serverName=localhost"

# too many files open
# https://docs.basho.com/riak/kv/2.1.4/using/performance/open-files-limit/
#ulimit -n 65536
#ulimit -u 2048

# autostart ssh agent if no passphrase
#eval $(ssh-agent)
#ssh-add

export PATH="/opt/Sencha/Cmd:$PATH"

# composer global

export PATH=~/.composer/vendor/bin:$PATH

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
