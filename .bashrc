####################################
#  _               _               #
# | |__   __ _ ___| |__  _ __ ___  #
# | '_ \ / _` / __| '_ \| '__/ __| #
# | |_) | (_| \__ \ | | | | | (__  #
# |_.__/ \__,_|___/_| |_|_|  \___| #
####################################

#
# Author : rootkill <rootkill.dedsec@gmail.com>
# Github : rootkill-g
#

#
# Miscellaneous
#

case $- in 
	*i*) ;;
	*) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

# HISTSIZE=500
# HISTFILESIZE=1000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

#
# PS1
#

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

export PS1="\[\e[1;31m\]┌─\[\e[1;33m\][\[\e[1;34m\]\u\[\e[1;33m\]]\[\e[1;31m\]-\[\e[1;33m\][\`emoji\`]\[\e[1;31m\]-\[\e[1;33m\][\[\e[1;34m\]\h\[\e[1;33m\]]\[\e[1;31m\]-\[\e[1;33m\][🦀]\[\e[1;31m\]-\[\e[1;33m\][\[\e[1;32m\]\w\[\e[1;33m\]]\[\e[1;31m\] \`git_branch\`\n\[\e[1;31m\]└─\[\e[1;33m\][\[\e[1;34m\]\$\[\e[1;33m\]] \[\e[m\]"

#
# Aliases
#

alias cat='bat'
alias exa='exa --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias ls='exa --icons'
alias l='ls -F'
alias la='ls -a'
alias ll='ls -alF'
alias lr='ls -aR'
alias nvim='lvim'
alias top='btm'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+//;s/[;&|]\s*alert$//'\'')"'

#
# Git Branch Function
#

git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
	if [ ! "${BRANCH}" == "" ] ; then
		STAT=`git_dirty`
    ICON=''
		echo "$ICON ${BRANCH}${STAT}"
	else
		echo ""
	fi
}

git_dirty() {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ] ; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ] ; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ] ; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ] ; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ] ; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ] ; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ] ; then
		echo " ${bits}"
	else
		echo ""
	fi
}

#
# Custom defined functions
#

#
# Month Emoji
#

emoji() {
  month=$(date '+%m');
  if [ "$month" == "01" ] ; then 
    emoji=🎉
  elif [ "$month" == "02" ] ; then 
    emoji=🍫
  elif [ "$month" == "03" ] ; then 
    emoji=💮
  elif [ "$month" == "04" ] ; then 
    emoji=🐰
  elif [ "$month" == "05" ] ; then 
    emoji=🌸
  elif [ "$month" == "06" ] ; then 
    emoji=🌈
  elif [ "$month" == "07" ] ; then 
    emoji=🌞
  elif [ "$month" == "08" ] ; then 
    emoji=🍎
  elif [ "$month" == "09" ] ; then 
    emoji=🍷
  elif [ "$month" == "10" ] ; then 
    emoji=🎃
  elif [ "$month" == "11" ] ; then 
    emoji=🦂
  elif [ "$month" == "12" ] ; then 
    emoji=🎄
  fi
  echo $emoji
}

#
# Run at the start of the shell
#

export BUN_INSTALL="$HOME/.bun"
export PATH=$PATH:$HOME/.local/bin:$BUN_INSTALL/bin
. "$HOME/.cargo/env"

