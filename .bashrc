
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
bind '"M-[A":history-search-backward'
bind '"M-[B":history-search-forward'

function sandbox { 
	mysql -h db_blood_m.mbga.dena.ne.jp -u mgsys "spapp_blood_g$1"
}

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
get_parent_dir() {
     filepath=`pwd`
     path=${filepath%/*}
     echo ${path##*/}
 }

get_sdk_version() {
    pwd | egrep -o '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | sed -e 's/\(.*\)/[\1] /'
}
export PS1="\[\033[35m\]\$(get_sdk_version)\[\033[00m\]\$(get_parent_dir)/\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
export HISTSIZE=5000;
export HISTCONTROL=erasedups
shopt -s histappend
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
