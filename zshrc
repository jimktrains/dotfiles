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
    branch=`git branch 2>/dev/null|grep -e '^*' | tr -d \*\ `
    stash_cnt=`git stash list 2>/dev/null | wc -l`
    short=`git rev-parse --short HEAD 2>/dev/null`
    bat_per=`acpi -b 2>&1 | grep -v found | sed 's/.*\([0-9]\{2\}%\).*/\1/'`
    bat_temp=`acpi -t 2>&1 | grep -v found | sed 's/.*\([0-9][0-9]\).*/\1C/'`
    bat_charge=`acpi -a 2>&1| grep -v found | sed 's/.*on-line*/+/' | sed 's/.*off-line.*/-/'`
    [ ! -z $branch ] && branch="($branch){$short}[$stash_cnt] "
	[ ! -z $bat_charge ] && bat="{$bat_charge$bat_per $bat_temp} "
	d=`date "+%a %F %T"`
	wd=`pwd`
	uah="`whoami`@`hostname`"
	echo "$uah $branch$bat$d $last_resp\n$wd"
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
alias ducks="du -k | sort -n | tail -n 200 | perl -ne 'if ( /^(\\d+)\\s+(.*$)/){\$l=log(\$1+.1);\$m=int(\$l/log(1024)); printf (\"%6.1f\\t%s\\t%25s %s\\n\",(\$1/(2**(10*\$m))),((\"K\",\"M\",\"G\",\"T\",\"P\")[\$m]),\"#\"x (1.5*\$l),\$2);}'"

export EDITOR=vim
export VISUAL=vim
export BROWSER=w3m
export PAGER=less

export PATH=$PATH:/usr/lib/firefox-3.6.15
export PATH=~/.composer/vendor/bin:$PATH

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
