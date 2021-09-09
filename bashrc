export SCHRODINGER_LIB=/software/lib
echo "SCHRODINGER="$SCHRODINGER


export LM_LICENSE_FILE=/scr01/anakkapp/license.lic
export SCHRODINGER_LICENSE_FALLBACK=0
export QTDIR=/software/lib/Linux-x86_64/qt-5.12.3-build2
export PATH=/software/lib/Linux-x86_64/qt-5.12.3-build2/bin:$PATH
export LD_LIBRARY_PATH=/software/lib/Linux-x86_64/qt-5.12.3-build2/lib:$LD_LIBRARY_PATH

function master(){
export SCHRODINGER=/scr01/anakkapp/build/master
export SCHRODINGER_SRC=/scr01/anakkapp/source/master
bash
}

function release(){
export SCHRODINGER=/scr01/anakkapp/build/2021-3
export SCHRODINGER_SRC=/scr01/anakkapp/source/2021-3
bash
}

function mmv(){
grep MMSHARE_VERSION $SCHRODINGER_SRC/mmshare/version.h | awk '{ printf("%03d\n", $3%1000+1) }'
}

gclone (){
git clone ssh://anakkapp@pdx-git.schrodinger.com/var/git/repos/${1}
}

alias jsc="$SCHRODINGER/jsc"
#alias msv="$SCHRODINGER/run msv.py"
alias mae="$SCHRODINGER/maestro -SGL"
alias jm="$SCHRODINGER/run job_monitor_gui.py"
alias pytest="$SCHRODINGER/utilities/py.test"
alias make_shell="cd ~/buildenvs/centos7 && make shell && cd ! && bash"
alias build_env="source $SCHRODINGER_SRC/mmshare/build_env"
alias build_mae="cd $SCHRODINGER_SRC/maestro-src && waf configure build install"
alias buildinger="$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh mmshare -j 5"
alias mp="make python"
alias nb="export SCHRODINGER=$(ls -td /nfs/builds/NB/2021-*/build-*/Linux-x86_64 | head -1) && bash"
alias ff="$SCHRODINGER/utilities/feature_flags"
alias designer="$SCHRODINGER/run $SCHRODINGER_LIB/Linux-x86_64/qt-5.12.3-build2/bin/designer"
source ~/scripts/.git_commands.sh
alias ipython="$SCHRODINGER/run /scr01/anakkapp/build/master/mmshare-v5.6/python/scripts/ipython_terminal.py"
alias sve="source /scr01/anakkapp/schrodiger.ve/bin/activate"
alias make_all="cd $SCHRODINGER/mmshare-v* && make all -j 5"

export mtest="$SCHRODINGER/mmshare-v*/python/test/application/msv/"
alias pycharm="$SCHRODINGER/run /snap/pycharm-community/current/bin/pycharm.sh"
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function dir_path() {
    if [[ $PWD =~ $schrodinger_build ]]; then
        relative_path=${PWD#${schrodinger_build}}
        echo "sdgr-build:${relative_path}"
    elif [[ $PWD =~ $schrodinger_src ]]; then
        relative_path=${PWD#${schrodinger_src}}
        echo "sdgr-src:${relative_path}"
    else
        echo $PWD
    fi
}
function new_line() {
	printf "\n$ "
}
function inside_docker() {
  if [ -f /.dockerenv ]; then
    echo "docker:";
  else
    echo "";
  fi
}
RED='0;31m\]'
GREEN='[0;32m\]'
case $TERM in
 xterm* | vt102*)
    PS1='\[\e[00;36m\]$(inside_docker)\u@\h:$(dir_path)\[\e[0;31m\]$(git_branch)\[\e[0m\]\[\e[0m\]$(new_line)'
   ;;
 *)
    PS1='\[\e[00;36m\]$(inside_docker)\u@\h:$(dir_path)\[\e[0;31m\]$(git_branch)\[\e[0m\]\[\e[0m\]$(new_line)'
   ;;
esac


complete -o default -o bashdefault export # fix tab completion
shopt -s direxpand # fix tab complete $ escape insanity

COMPOSE_PROJECT_NAME=$USER
export COMPOSE_PROJECT_NAME=${USER}_${PWD/*\//}

alias discardpull="git reset --keep HEAD@{1}"

alias msv="$SCHRODINGER/run msv.py ~/Test/1fjs.mae ~/Test/1fjs_chainA.pdb ~/Test/1fjs_L.pdb"


source /home/anakkapp/scripts/.git-auto-completion.sh
