#!/bin/sh
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

if [ -f /etc/profile.d/color_prompt.sh ]; then
    . /etc/profile.d/color_prompt.sh
fi

if [ -f /etc/profile.d/256term.sh ]; then
    export COLORTERM=1
    #export SEND_256_COLORS_TO_REMOTE=1
    #. /etc/profile.d/256term.sh
    #unset SEND_256_COLORS_TO_REMOTE
fi

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/AndroidSDK:$HOME/AndroidSDK/tools:$HOME/AndroidSDK/platform-tools

export PATH

# gnome-terminal
export VTE_BACKEND=Pango

# fixed the width of firefox input textbox
#export LC_MESSAGES="en_US.UTF-8"

export OOO_FORCE_DESKTOP=gnome
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
#export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export JAVA_FONTS=/usr/share/fonts

export GDK_USE_XFT=1
export QT_XFT=true
export MOZ_DISABLE_PANGO=1

# audtty for remote TTY
if [ -z "$DISPLAY" ]; then
    . ~/.dbus-session
else
    . /opt/local/bin/dbus_audtty.sh
fi

# LibreOffice digital signature
PROFILE=$(ls $HOME/.thunderbird | grep default)
export MOZILLA_CERTIFICATE_FOLDER="$HOME/.thunderbird/$PROFILE"

unset SSH_ASKPASS

# NNTP Server
#export NNTPSERVER=news.cs.nthu.edu.tw
export NNTPSERVER=nntp.aioe.org

# TMUX
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# aliases
alias pssp='pss --perl'
alias pssr='pss --ruby'
alias lh='ls -h'
alias vless='/opt/local/src/vcs/vimpager/vimpager'

export EDITOR=vim
export NSPR_LOG_FILE=/tmp/tbtrace.lyshie.log
export NSPR_LOG_MODULES=NNTP:5,SMTP:5,POP3:5,IMAP:5,sync:1,timestamp,nsHostResolver:4
