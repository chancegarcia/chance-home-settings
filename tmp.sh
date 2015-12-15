#!/bin/bash

source ~/.git-completion.bash
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
# use legacy to show expected upstream states; look into why later
GIT_PS1_SHOWUPSTREAM="auto legacy"
GIT_PS1_DESCRIBE_STYLE="default"
#GIT_PS1_SHOWCOLORHINTS=true
status=$(__git_ps1)
if [[ $status =~ ^(.*)([\*])(.*)$ ]]
# a file has been modified but not added
then statusColor="yellow"; echo -e "${BASH_REMATCH[3]}"
elif [[ $status =~ [\+|\=] ]]
# a file has been added, but not commited
then statusColor="red"
# the state is clean, changes are commited
else statusColor="green"
fi

echo $statusColor
echo $status