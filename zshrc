if [[ -f /etc/profile ]]; then
        source /etc/profile
fi

#if [[ -f $HOME/.bashrc ]]; then
#        source $HOME/.bashrc
#fi
#

#jim@lilith (master){4bd9626}[1] {+39% } Wed 2015-04-22 10:11:52 0
#/home/jim/dotfiles
#%
function precmd {
  last_resp=$?
  if [ -d .git ]; then
    branch=`git branch 2>/dev/null|grep -e '^*' | tr -d \*\ `
    stash_cnt=`git stash list 2>/dev/null | wc -l`
    short=`git rev-parse --short HEAD 2>/dev/null`
  fi

  bat_per=`acpi -b 2>&1 | grep -v found | sed 's/.*\([0-9]\{2\}%\).*/\1/' | xargs echo`
  bat_temp=`acpi -t 2>&1 | grep -v found | sed 's/.*\([0-9][0-9]\).*/\1°C/' | xargs echo`
  bat_charge=`acpi -a 2>&1| grep -v found | sed 's/.*on-line*/+/' | sed 's/.*off-line.*/-/'`
  if [ -e .crinc.yaml ]; then
    berth=`crinc --quiet config show --key defaultBerth`
    kube_context=`kubectl config get-contexts | grep "*" | awk '{print $2}' | cut -d / -f 2`
    aws_region=`aws configure get region`
  fi

  [ ! -z $branch ] && branch="($branch){$short}[$stash_cnt] "
  [ ! -z $bat_charge ] && bat="🔋$bat_charge$bat_per $bat_temp🔋 "
  [ ! -z $berth ] && berth="⟦${berth}⟧ "
  [ ! -z $aws_region ] && aws_region="«$aws_region» "
  [ ! -z $kube_context ] && kube_context="<$kube_context> "

  d=`date "+%a %F %T"`
  wd=`pwd`
  uah="`whoami`@`hostname`"
  echo "$uah ${branch}${bat}${d} ${kube_context}${aws_region}${berth}$last_resp\n$wd"
  export PS1="%# "
}
autoload -U compinit promptinit
compinit
promptinit

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh/history
setopt append_history
setopt inc_append_history
setopt extended_history
# Causes issues with mangled lines
# http://www.zsh.org/mla/users/2013/msg00457.html
#setopt histreduceblanks
setopt histignorespace
setopt histfindnodups

alias ls="ls -F --color=never"

export EDITOR=vim
export VISUAL=vim
#export BROWSER=w3m
export PAGER=less

export PATH=$PATH:/usr/lib/firefox-3.6.15
export PATH=~/.composer/vendor/bin:$PATH
export PATH=~/.config/composer/vendor/bin:$PATH
export PATH=/home/jim/MSQC/code/crinc:$PATH

#I know it won't infinitely connect (good work guys!)
#I just don't want to hear it complain
#if [ x$TERM != xscreen ]; then
#    screen -xRS default
#fi

[[ -x `which fortune` ]] && fortune

# Setting Editor to vim sets the bindkeys in zsh as well
# I may want to make it vim later, but for now I'm a bit more
# comforable with the emacs bindings
bindkey -e

alias emacs='emacs -nw'

#source ~/.rvm/scripts/rvm
source ~/.cargo/env


ssh-add -l &>/dev/null
if [ "$?" -eq 2 ]; then
  test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null

  ssh-add -l &>/dev/null
  if [ "$?" -eq 2 ]; then
    (umask 066; ssh-agent > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    ssh-add
  fi
fi

PATH=${PATH}:$HOME/bin

# export PATH="/home/jim/.ebcli-virtual-env/executables:$PATH"
# export PATH=/home/jim/.pyenv/versions/3.7.2/bin:$PATH
#
ssh-add ~/MSQC/code/CreativityHub/config/aws/keys/msqc_app-key-pair.pem 2> /dev/null > /dev/null

autoload -U bashcompinit
bashcompinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

crinc_path=`which crinc`
[ -n "$crinc_path" ] && eval "$(register-python-argcomplete $crinc_path)"


alias ducks="du -k | sort -n | tail -n 200 | perl -ne 'if ( /^(\\d+)\\s+(.*$)/){\$l=log(\$1+.1);\$m=int(\$l/log(1024)); printf (\"%6.1f\\t%s\\t%25s %s\\n\",(\$1/(2**(10*\$m))),((\"K\",\"M\",\"G\",\"T\",\"P\")[\$m]),\"#\"x (1.5*\$l),\$2);}'"

