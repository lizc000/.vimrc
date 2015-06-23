# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   # PS1='${debian_chroot:+($debian_chroot)}\u@:\w\$ '
    PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@:\[\033[01;34m\] \w\[\033[00m\]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export HISTCONTROL=ignoreboth
shopt -s histappend
export HISTSIZE=1000000 HISTFILESIZE=1000000

export PATH=/opt/bin:$PATH
export PATH=/home/lizc/workspace/tools/repo:$PATH
export PATH=/home/lizc/workspace/tools/bin:$PATH

############################# SAMSUNG JDK ##############################
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export PATH=.:~/bin:/usr/lib/jvm/java-7-openjdk-amd64/bin/:/usr/local/sbin/:/usr/local/bin/:/usr/bin/:/sbin:/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=/home/lizc/workspace/tools/arm/aarch64-toolchain/gcc-linaro-aarch64-linux-gnu-4.8-2014.01_linux/bin/aarch64-linux-gnu-

############################### PND JDK ################################
#export PATH=/home/lizc/workspace/source/src-dvt/out/host/linux-x86/bin:$PATH
#export JAVA_HOME=/home/lizc/workspace/tools/jdk1.6.0_45
#export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
#export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib


alias zmkm='nautilus .'
alias fastboot='sudo fastboot'
alias 123='sudo shutdown -h now'
alias ll='ls -alh'
alias showb='gnome-terminal --full-screen -x cmatrix -b'
alias pdf='evince '
alias adbrb='adb reboot bootloader'
alias fr='fastboot reboot'
alias frb='fastboot reboot-bootloader'
alias svnupdate='svn update --username lizc0826 --password lizc0826'
alias gituser='git log --pretty=format:"%H - %ae, %ar : %s" |grep '
alias gitlog='git log --pretty=format:"%H - %ae, %ar : %s"'
alias fu='sudo fastboot flash bootloader u-boot.bin;sudo fastboot flash bl2 smdk7580-spl_final.bin;sudo fastboot flash fwbl1 7580.nbl1_141128.bin;sudo fastboot flash el3_mon el3_mon.bin'
alias untar='tar xvf '

#### CD PATH
alias c1='cd ../'
alias c2='cd ../../'
alias c3='cd ../../../'
alias c4='cd ../../../../'
alias c5='cd ../../../../../'
alias c6='cd ../../../../../../'
alias c7='cd ../../../../../../../'
alias c8='cd ../../../../../../../../'
alias co='cd `pwd`/out/target/product/mochagw01'

###################################################################

#http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
# jump path
export MARKPATH=$HOME/.marks
function c { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -rf "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
	local curw=${COMP_WORDS[COMP_CWORD]}
	local wordlist=$(find $MARKPATH -type l -printf "%f\n")
	COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
	return 0
}
complete -F _completemarks c unmark
