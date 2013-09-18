export LC_ALL=en_US.UTF-8
declare -a CURRENT_PROJECT
CURRENT_PROJECT[0]='feature/porori_gacha2'
CURRENT_PROJECT[1]='feature/ranking_gacha'
CURRENT_PROJECT[2]='feature/event_pvp13'
export CURRENT_NGCORE="ngcore-sdk-1.11.2.1"
export CURRENT_JP_NGCORE="ngcore-sdk-1.11.1.6"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias la="ls -laG"
alias mvim="open /Applications/MacVim.app"
source ~/perl5/perlbrew/etc/bashrc
alias mysqld="/Library/StartupItems/MySQLCOM/MySQLCOM"
alias kenshuu="cd ~/perl-exam/bailey.michael"
alias mysql="/usr/local/mysql/bin/mysql"
alias hossh="ssh training@192.168.56.101"
alias jerome="ssh jerome@192.168.56.101"
alias mobasrc="cd /Users/bailey.michael/Downloads/moba-software/moba-0.9.0"
alias mhttpd="sudo /usr/local/apache/bin/apachectl"

alias perm="chmod 755 ./*"

export DEV_FOLDER=/Users/bailey.michael/development
export DEV_SCRIPTS=$DEV_FOLDER/scripts
PATH=/usr/local/bin:$PATH:$HOME/bin:.:$DEV_FOLDER/android-sdk-macosx/platform-tools:$DEV_FOLDER
export PATH
export BB_PATH=$DEV_FOLDER/$CURRENT_NGCORE/SDK/Apps/BloodBrothers
export BB2_PATH=$DEV_FOLDER/$CURRENT_NGCORE/SDK/Apps/BloodBrothers2
export BBJP_PATH=$DEV_FOLDER/$CURRENT_JP_NGCORE/SDK/Apps/BloodBrothers
export BBJP2_PATH=$DEV_FOLDER/$CURRENT_JP_NGCORE/SDK/Apps/BloodBrothers2
export BS_PATH=$DEV_FOLDER/BloodBrothersServer
export BS2_PATH=$DEV_FOLDER/BloodBrothersServer2

alias bb="cd $BB_PATH"
alias bc="cd $BB_PATH"
alias bb2="cd $BB2_PATH"
alias bbjp="cd $BBJP_PATH"
alias bbjp2="cd $BBJP2_PATH"
alias bs="cd $BS_PATH"
alias bs2="cd $BS2_PATH"
alias cddev="cd $DEV_FOLDER"
alias cdscript="cddev; cd scripts"
alias cdserv="cdscript; cd servers"
alias sim="$DEV_FOLDER/$CURRENT_NGCORE/SDK/iOS/Release-iphonesimulator/webgame_US_LIVE_SAND_SDK-iPhone-Simulator.app/Contents/MacOS/Launcher"

alias ebp="vim ~/.bash_profile"

alias gsu="git submodule update"
alias ,="cd -"
alias ga="git config --list | grep alias | sed 's/^alias.//' | sed 's/=/	=	/'"
alias gd="git co develop"
alias gjp="git co xbd/xbd-jp-2"
alias gs="git st"
alias gp="git pull"
alias gl="git log"
alias gm="git co master"
alias gmd="git merge develop"

alias gaj="git add Code/packed_us.js; git add Code/packed_jp.js"
alias gjson="make pack-json; gaj;"
alias servthis="cd ngCore; npm link; cd ..; npm link; npm link ngServer;"

alias so="source ~/.bash_profile"

alias pushios="cp build.zip ../../Tools/ngPackager/ ; cd ../../Tools/ngPackager ; ./ngPackager.js -dr --appId Blood-Brothers-iOS --userId takami.kosuke@dena.jp --gamePath ./build.zip"
alias pushandroid="cp build.zip ../../Tools/ngPackager/ ; cd ../../Tools/ngPackager ; ./ngPackager.js -dr --appId Blood-Brothers-Android --userId takami.kosuke@dena.jp --gamePath ./build.zip"

export SIMFOLDER="~/Library/Application\ Support/iPhone\ Simulator"
function projects () {
    for i in "${!CURRENT_PROJECT[@]}"; do 
      printf "%s\t%s\n" "$i" "${CURRENT_PROJECT[$i]}"
    done
}

function cdbb () {
    cd $DEV_FOLDER/ngcore-sdk-$1/SDK/Apps/BloodBrothers
}
function installApp () {
    region="WW"
    sdk="6.0"
    if [ "$1" = "JP" ]
    then
        region="JP"
    fi
    if [ -z "$2" ]
    then
        sdk="6.0"
    else
        sdk="$2"
    fi
    echo "/bin/cp" "$DEV_FOLDER/backup_launcher/$region/" "$SIMFOLDER/$sdk/"
    #/bin/cp -r "$DEV_FOLDER""/backup_launcher/""$region""/" "$SIMFOLDER""/""$sdk""/"

}
function kill-it-with-fire () {
    switch=0
    if [ "$1" = "develop" ]
    then
        switch='master'
    else
        switch='develop'
    fi
    git checkout $switch
    git pull
    git branch -D $1
    git checkout -t origin/$1
}

function git-when () {
    limit=10
    if [ "$1" ] ; then
        if [[ "$1" =~ ^[0-9]+$ ]]
        then
            limit=$1
        fi
    fi
    if [ "$2" ] ; then
        if [[ "$2" =~ ^[0-9]+$ ]]
        then
            limit=$2
        fi
    fi
    if [ "$1" = "--local" || "$2" = "--local"]
    then
        for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r -u|head -$limit
    else
        for k in `git branch -r|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k|head -n 1`\\t$k;done|sort -r -u|head -$limit
    fi

}


bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'


function gn () {
   value=0
   if [ $CURRENT_PROJECT ]
   then
        if [ $# -gt 0 ]
        then
            value=$1
       else
            value=0
        fi
        echo git checkout ${CURRENT_PROJECT[value]}
        git co ${CURRENT_PROJECT[value]}
   else 
        echo "git checkout develop"
        git co develop
   fi
}
function gnjp () {
   if [ $CURRENT_PROJECT ]
   then
        if [ $# -gt 0 ]
        then
            value=$1
       else
            value=0
        fi
        echo git checkout ${CURRENT_PROJECT[value]}"_jp"
        git co ${CURRENT_PROJECT[value]}"_jp"
   else
       echo "git checkout xbd/xbd-jp-2"
       git co xbd/xbd-jp-2
   fi  
}

function change-project () {
    if [ $# -lt 1 ]
    then
        echo "provide a project name"
    else
        if [ $# -gt 1 ]
        then
            CURRENT_PROJECT[$2]=$1
        else
            CURRENT_PROJECT[0]=$1
        fi
    fi
}

function make-swap () {
    echo "Switching in Makefile"
    /bin/cp "$DEV_SCRIPTS""/Makefile" "$BB_PATH""/Makefile"
}

function mserv-swap () {
    if [ $# -lt 1 ]
    then
        echo "Usage : {1-5 | 0 (local) | 11-15 | 10 (localJP) }"
        exit
    fi

    if [ $1 -lt 10 ]
    then
        make toggle-us
    else
        make toggle-jp
    fi

    echo "Switching in serv=$1"
    /bin/cp "$DEV_SCRIPTS""/servers/config$1"".js" "$BB_PATH""/Config/development.js"
    echo "make server"
    make server-debug
}

function mpj () {
    if [ "$1" ] ; then
        make pack-json;
        mserv-swap 0;
    else
        make pack-json;
    fi
}

function db-swap () {
    if [ $# -lt 1 ]
    then
        echo "Usage : {1 | 2 | 3 | 4 | 5 | 0 (default) }"
        exit
    fi

    echo "Switching in file Database Config: $1"
    /bin/cp "$DEV_SCRIPTS""/local_db/default$1"".js" "$BS_PATH""/config/default.js"
}

function run-app () {
EXEC="$1"
APPDIR="$HOME/Library/Application Support/\
    iPhone Simulator/6.0/Applications"

TRCSUB=Contents/Applications/Instruments.app\
    /Contents/PlugIns/AutomationInstrument.bundle\
    /Contents/Resources/Automation.tracetemplate
TOPDIR="$APPDIR/$(appuuid "$EXEC")"
if [ ! -d "$TOPDIR/$EXEC.app" ]; then
    echo "runsim: app \"$EXEC\" not installed" >&2
    exit 1
fi
(instruments -D /tmp/runsim$$.trace -t "Applications/Xcode.app/$TRCSUB" \
        "$TOPDIR/$EXEC.app" < /dev/null 2>&1 > /dev/null | \
        grep 'xcodebuild -license' >&2 ; \
    rm -rf /tmp/runsim$$.trace) 
}

# =============================================================== #
#
# PERSONAL $HOME/.bashrc FILE for bash-3.0 (or later)
# By Emmanuel Rouat [no-email]
#
# Last modified: Tue Nov 20 22:04:47 CET 2012

#  This file is normally read by interactive shells only.
#+ Here is the place to define your aliases, functions and
#+ other interactive features like your prompt.
#
#  The majority of the code here assumes you are on a GNU
#+ system (most likely a Linux box) and is often based on code
#+ found on Usenet or Internet.
#
#  See for instance:
#  http://tldp.org/LDP/abs/html/index.html
#  http://www.caliban.org/bash
#  http://www.shelldorado.com/scripts/categories.html
#  http://www.dotfiles.org
#
#  The choice of colors was done for a shell with a dark background
#+ (white on black), and this is usually also suited for pure text-mode
#+ consoles (no X server available). If you use a white background,
#+ you'll have to do some other choices for readability.
#
#  This bashrc file is a bit overcrowded.
#  Remember, it is just just an example.
#  Tailor it to your needs.
#
# =============================================================== #

# --> Comments added by HOWTO author.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------


if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
      . ~/.bashrc   # --> Read /etc/bashrc, if present.
fi


#--------------------------------------------------------------
#  Automatic setting of $DISPLAY (if not set already).
#  This works for me - your mileage may vary. . . .
#  The problem is that different types of terminals give
#+ different answers to 'who am i' (rxvt in particular can be
#+ troublesome) - however this code seems to work in a majority
#+ of cases.
#--------------------------------------------------------------

function get_xserver ()
{
    case $TERM in
        xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
            # Ane-Pieter Wieringa suggests the following alternative:
            #  I_AM=$(who am i)
            #  SERVER=${I_AM#*(}
            #  SERVER=${SERVER%*)}
            XSERVER=${XSERVER%%:*}
            ;;
            aterm | rxvt)
            # Find some code that works here. ...
            ;;
    esac
}

if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
       ${XSERVER} == "unix" ]]; then
          DISPLAY=":0.0"          # Display on local host.
    else
       DISPLAY=${XSERVER}:0.0     # Display on remote host.
    fi
fi

export DISPLAY

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"

ulimit -S -c 0      # Don't want coredumps.
set -o notify
set -o noclobber
set -o ignoreeof


# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.




#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------
# Current Format: [TIME USER@HOST PWD] >
# TIME:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# USER:
#    Cyan      == normal user
#    Orange    == SU to user
#    Red       == root
# HOST:
#    Cyan      == local session
#    Green     == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Green     == more than 10% free disk space
#    Orange    == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
# >:
#    White     == no background or suspended jobs in this shell
#    Cyan      == at least one background job in this shell
#    Orange    == at least one suspended job in this shell
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').


# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=        # Connected on remote machine, via ssh (good).
elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    CNX=${ALERT}        # Connected on remote machine, not via ssh (bad).
else
    CNX=${BCyan}        # Connected on local machine.
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
    SU=${Red}           # User is root.
elif [[ ${USER} != $(logname) ]]; then
    SU=          # User is not login user.
else
    SU=${BCyan}         # User is normal (well ... most of us are).
fi




# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load()
{
    local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
    # System load of the current host.
    echo $((10#$SYSLOAD))       # Convert to decimal.
}

# Returns a color indicating system load.
function load_color()
{
    local SYSLOAD=$(load)
    if [ ${SYSLOAD} -gt ${XLOAD} ]; then
        echo -en ${ALERT}
    elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
        echo -en ${Red}
    elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
        echo -en 
    else
        echo -en 
    fi
}

# Returns a color according to free disk space in $PWD.
function disk_color()
{
    if [ ! -w "${PWD}" ] ; then
        echo -en ${Red}
        # No 'write' privilege in the current directory.
    elif [ -s "${PWD}" ] ; then
        local used=$(command df -P "$PWD" |
                   awk 'END {print $5} {sub(/%/,"")}')
        if [ ${used} -gt 95 ]; then
            echo -en ${ALERT}           # Disk almost full (>95%).
        elif [ ${used} -gt 90 ]; then
            echo -en             # Free disk space almost gone.
        else
            echo -en            # Free disk space is ok.
        fi
    else
        echo -en 
        # Current directory is size '0' (like /proc, /sys etc).
    fi
}

# Returns a color according to running/suspended jobs.
function job_color()
{
    if [ $(jobs -s | wc -l) -gt "0" ]; then
        echo -en 
    elif [ $(jobs -r | wc -l) -gt "0" ] ; then
        echo -en ${BCyan}
    fi
}

# Adds some text in the terminal frame (if applicable).



#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#+ be converted into scripts and removed from here.
#
#============================================================

#-------------------
# Personnal Aliases
#-------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'


alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h -G'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSCHARSET='utf-8'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


#-------------------------------------------------------------
# Spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'


#-------------------------------------------------------------
# A few fun ones
#-------------------------------------------------------------

# Adds some text in the terminal frame (if applicable).

function xtitle()
{
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\e]0;$*\a" ;;
    *)  ;;
    esac
}


# Aliases that use xtitle
alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'

# .. and functions
function man()
{
    for i ; do
        xtitle The $(basename $1|tr -d .[:digit:]) manual
        command man -a "$i"
    done
}


#-------------------------------------------------------------
# Make the following commands run in background automatically:
#-------------------------------------------------------------

function te()  # wrapper around xemacs/gnuserv
{
    if [ "$(gnuclient -batch -eval t 2>&-)" == "t" ]; then
       gnuclient -q "$@";
    else
       ( xemacs "$@" &);
    fi
}

function soffice() { command soffice "$@" & }
function firefox() { command firefox "$@" & }
function xpdf() { command xpdf "$@" & }


#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------


# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr()
{
    OPTIND=1
    local mycase=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
           i) mycase="-i " ;;
           *) echo "$usage"; return ;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}


function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}


function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig en1 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nAdditionnal information: " ; uname -a
    echo -e "\nCurrent date : " ; date
    echo -e "\nMachine stats : " ; uptime
    echo -e "\nMemory stats : " ; free
    echo -e "\nDiskspace : " ; mydf / $HOME
    echo -e "\nLocal IP Address :" ; my_ip
	echo
}

eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`

##
# Your previous /Users/bailey.michael/.bash_profile file was backed up as /Users/bailey.michael/.bash_profile.macports-saved_2013-04-30_at_12:43:04
##

# MacPorts Installer addition on 2013-04-30_at_12:43:04: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

