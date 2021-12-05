export LSCOLORS="Exfxcxdxbxegedabagacad"
export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"

umask 002
export LV='-Ou8'

bindkey -e

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

autoload -U compinit
compinit

setopt autopushd
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


autoload colors
colors

hostname=`hostname -s`
PROMPT=$'\n'"%{${fg[blue]}%}%T%{${reset_color}%} %{${fg[green]}%}[%~]%{${reset_color}%}"$'\n'"[${USER}@$hostname] %(!.#.$) "
#PROMPT=$'\n'"%{${fg[blue]}%}%T%{${reset_color}%}"$'\n'"[${USER}@$hostname] %(!.#.$) "
#RPROMPT="%{${fg[green]}%}[%~]%{${reset_color}%}"

export EDITOR=vi
alias perldocc='carton exec -- perldoc'
alias ls='ls -G'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
#alias screen='screen -U -d -RR'
alias tmpday='
tmp="$HOME/tmp"
target="$tmp/"`date +%Y/%m/%d`
if [ ! -d $target ]
then 
    mkdir -p $target
fi
cd $target
'

if [ "$TERM" = "screen" ]
then
    chpwd () { echo -n "_`dirs`\\" }
    preexec () {
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 ))
                then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2 ))
                then
                    cmd[1]=$cmd[2]
                fi
                ;;
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
                cmd=(${(z)${(e):-\$jt$num}})
                echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi
PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null 2>&1
then
    eval "$(rbenv init -)"
fi
PATH="$HOME/.plenv/bin:$PATH"
if which plenv > /dev/null 2>&1
then
    eval "$(plenv init - zsh)"
fi
