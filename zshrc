#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
#
#

# TODO -- wishlist
# repo status and branch working in prompt (not slow)
# hyphens and underscores are equivalent in ctrl-r matches
# mouse support on command line
# want to turn off @ and / at the ends of links and dirs in complete menu
# color files with endings in ls and completion menu
# real 256 color support
# completion dots
# remove background colour from grep --color highlighting

export LOCAL=$HOST
set mouse=a

IFS=$(echo -en "\t\n\0") # fix for breaking on spaces not newlines

# brew caveats (using zsh installed via brew)
if [[ $HOST == $LOCAL ]]; then 
    unalias run-help
    autoload run-help
    HELPDIR=/usr/local/share/zsh/help
fi


# PLUGINS

# Mouse support on command line
# Broken -- can click to go to anywhere on line, but cannot double click to select text
# 
#if [ -f ~/.zsh/mouse.zsh ]; then
#    . ~/.zsh/mouse.zsh
#    zle-toggle-mouse
#fi

# END PLUGINS


# Set the title of iterm2 tabs to the useful part of the directory
function precmd {
    # adapted from http://aperiodic.net/phil/prompt/
    local titlelen=20
    TITLE=$(print -P "%$titlelen<...<%~")
    echo -ne "\e]1;$TITLE\a"
}


# Colour settings

# enable colour names instead of escape chars
autoload -U colors && colors

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

export GREP_COLOR='1;35;40'

if [[ $HOST == $LOCAL ]]; then 
    alias grep='grep --color=auto'
    alias ls="gls --quoting-style=literal --color=auto"
    alias diff='colordiff -u'
else
    alias grep='grep --color=auto'
fi

alias tmux='tmux -2 -u' # colours and utf-8 support


# need to rework this section
if [[ $HOST == $LOCAL ]]; then 
    # For gnu ls
    export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:*.fasta=35:*.fa=35'
else
    # For bsd ls
    export LSCOLORS=exfxgxcxdxegeddedcedeb
    export LS_COLORS='di=34:ln=35:so=36:pi=32:ex=33:bd=34;46:cd=34;43:su=33;44:sg=33;42:tw=34;43:ow=34;41:'
fi

if [[ $TERM =~ "-256color$" ]]; then
    export LS_COLORS='di=\e[38;5;33:ln=35:so=36:pi=32:ex=33:bd=34;46:cd=34;43:su=33;44:sg=33;42:tw=34;43:ow=34;41:*.fasta=35:*.fa=35:'
    export TREE_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:*.fasta=35:*.fa=35'
fi




# Prompt functions from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

function repo_prompt_char {
    # set prompt character if we are in a repository
    if [[ `pwd` =~ mnt ]]; then
        #echo '⦰' #⊗
        echo 'x'
    else
        #git branch >/dev/null 2>/dev/null && echo '●' && return
        git branch >/dev/null 2>/dev/null && echo '.' && return
        hg root >/dev/null 2>/dev/null && echo '☿' && return
        #echo '○'
        echo 'o'
    fi
}

function hg_prompt_info {
    # get information if we are in an hg repository
    if [[ `pwd` =~ mnt ]]; then
        # pass
    else
        hg prompt --angle-brackets "\
< on <branch>>\
< at <tags|, >>\
<status|modified|unknown><update><
patches: <patches|join( → )>>" 2>/dev/null
    fi
}


# Other functions

# Find newest work in a directory tree
newest () { 
    local lines=10
    if [[ $1 != "" ]]; then
        lines=$1
    fi
	find . -type f -printf '%T@ %p \n'|sort -n|tail -n $lines|cut -f2 -d " "
	# find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -n | tail -n 10|cut -f2 -d " "
    #paste <( for d in `find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -n | tail -n $LINES | cut -f1 -d" "`; do date -j -f %s $d +%a" "%d" "%b" "%k":"%M; done ) <(find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -n | tail -n $LINES | cut -f2 -d" ") 
}

sam () {
	[ -f "$1" ] && input="$1" || input="-"
	cat $input | nl | gshuf | head | sort -n | cut -f2-
}

# Correct prompt shapes for vi mode
# from https://emily.st/2013/05/03/zsh-vi-cursor/
# only works with iterm2
function zle-keymap-select zle-line-init
{
    # change cursor shape in iTerm2
    case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
        viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
    esac

    zle reset-prompt
    zle -R
}

function zle-line-finish
{
    print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}


zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select


# End functions




# Set up the prompt

setopt promptsubst # enable substitution in prompt 
unsetopt promptcr

# Available colours
# for colour in {0..255}; do echo -e "\e[38;05;${colour}m $colour Test"; done
# for code in 53 80 95 180 28 209 18 16 52 88 124 130 215 117 111 105 69 20 211 ; do echo -e "\e[38;05;${code}m $code: Selected"; done
COLOURS="
\e[mm         grey
\e[1m1m
\e[0;30m0;30m black
\e[0;31m0;31m white
\e[0;32m0;32m red
\e[0;33m0;33m yellow
\e[0;34m0;34m blue
\e[0;35m0;35m green
\e[0;36m0;36m cyan
\e[0;37m0;37m purple
\e[1;30m1;30m
\e[1;31m1;31m
\e[1;32m1;32m
\e[1;33m1;33m
\e[1;34m1;34m
\e[1;35m1;35m
\e[1;36m1;36m
\e[1;37m1;37m
"

# one line old prompt
#PS1=$'%{\e[0;35m%}%T{%{\e[0;37m%}%n@%m%{\e[0;35m%}}%?%# %{\e[0;37m%}'
#RPROMPT=$'%{\e[0;30m%}%B%~%b%{\e[0;37m%}'

# variables for prompt
PS1_TIME="%{%F{52}%}%T"
PS1_CMDNO="%{%F{52}%}%h"
PS1_GIT="%{%F{223}%}"

PS1_USER_HOST="%{%F{33}%}%n%{%F{238}%}@%{%F{33}%}%m%{%F{238}%}[%y]"
PS1_DIR="%{%F{45}%}%~"
PS1_ERROR_CODE="%(? %{%F{33}%} %{%F{124}%})%?"
PS1_REPO="%{%F{210}%}"
PS1_PRMT="%{%F{33}%}%# %{%F{grey}%}"
PS1_OPEN_BR="%{%F{238}%}("
PS1_CLOSE_BR="%{%F{238}%})" 
PS1_MID_BR="%{%F{238}%})-("


# TODO don't have git_prompt_info working yet
#PS1='
#$PS1_OPEN_BR$PS1_ERROR_CODE$PS1_MID_BR$PS1_TIME$PS1_MID_BR$PS1_USER_HOST$PS1_MID_BR$PS1_DIR$PS1_CLOSE_BR
#$PS1_OPEN_BR$PS1_CMDNO$PS1_MID_BR$PS1_COL$(repo_prompt_char)$PS1_CLOSE_BR$PS1_COL$(hg_prompt_info)$PS1_COL$(git_prompt_info)$PS1_PRMT'


if [[ $HOST == $LOCAL ]]; then 
PS1='
$PS1_OPEN_BR$PS1_USER_HOST$PS1_MID_BR$PS1_DIR$PS1_CLOSE_BR
$PS1_OPEN_BR$PS1_ERROR_CODE$PS1_MID_BR$PS1_REPO$(repo_prompt_char)$PS1_CLOSE_BR$PS1_PRMT'

else
    PS1_ERROR_CODE="%(? %{%F{88}%} %{%F{124}%})%?"
    PS1_USER_HOST="%{%F{88}%}%n%{%F{238}%}@%{%F{88}%}%m%{%F{238}%}[%y]"
    PS1_DIR="%{%F{95}%}%~"
    PS1_PRMT="%{%F{88}%}%# %{%F{grey}%}"
    PS1='
$PS1_OPEN_BR$PS1_USER_HOST$PS1_MID_BR$PS1_DIR$PS1_CLOSE_BR
$PS1_OPEN_BR$PS1_ERROR_CODE$PS1_CLOSE_BR$PS1_PRMT'

fi



########## Completion

setopt complete_in_word

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
# do file name completion if all other completions fail
zstyle ':completion:*' completer _complete _ignored _files

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list true
zstyle ':completion:*:history-words' menu yes


# custom extensions

compctl -k "( interaction.cbs.dtu.dk )" scp
compctl -k "( computerome.cbs.dtu.dk )" scp


########## End Completion


# History config
export HISTFILE=~/.history
setopt EXTENDED_HISTORY     # store date in .history
export SAVEHIST=9999999     # number of lines to save
export HISTSIZE=$SAVEHIST   # number of lines from .history to read in at start of new shell
setopt HIST_IGNORE_ALL_DUPS # history is de-duped
setopt INC_APPEND_HISTORY   # append as we execute, not when we leave the shell
setopt SHARE_HISTORY       # share one history between all open shells


# Env variables

export LANG=C
export LC_ALL=C

if [[ $HOST == $LOCAL ]]; then 
    export LC_ALL=en_US.UTF-8

    export PATH=/usr/local/bin:$PATH:$HOME/Google\ Drive/Protein_prediction_from_genomic_data/bin:$HOME/Google\ Drive/Human-Virus-PPI/bin:$HOME/bin:$HOME/projects/crete_retreat/ptmcons/src/iupred

    export PERL5LIB=$PERL5LIB:$HOME/lib:$HOME/ensemble/bioperl-1.6.1:${HOME}/ensemble/ensembl/modules:${HOME}/ensemble/ensembl-compara/modules:${HOME}/src/ensembl-variation/modules:${HOME}/src/ensembl-funcgen/modules:${HOME}/Google\ Drive/Protein_prediction_from_genomic_data/lib:

    #export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$HOME/Google\ Drive/Human-Virus-PPI/data:$PYTHONPATH

else 

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib

    if [[ -d /tools ]]; then
        export LD_LIBRARY_PATH=/tools/lib64:/tools/usr/lib64:/tools/lib:/tools/usr/lib:$LD_LIBRARY_PATH
        export PATH=/tools/bin:/tools/usr/bin:$path
    fi

    if [[ -d /usr/java/latest ]]; then
        export JAVA_HOME=/usr/java/latest
        export JRE_HOME=$JAVA_HOME/jre
        export PATH=$JAVA_HOME/bin:$PATH
    fi

    export PATH=$PATH:/usr/cbs/tools/bin/Linux/x86_64:/usr/cbs/solutions/bin:/usr/cbs/solutions/bin/$UNIX
    export PATH=$PATH:/usr/cbs/tools/bin/linux:/usr/cbs/tools/bin

    export MANPATH=$MANPATH:/usr/cbs/tools/man

    if [[ -d /usr/cbs/bio/bin/$UNIX/$HW ]]; then
        export PATH=$PATH:/usr/cbs/bio/bin/$UNIX/$HW
    fi

    if [[ -d /usr/cbs/solutions/bin/$UNIX/$HW ]]; then
        export PATH=$PATH:/usr/cbs/solutions/bin/$UNIX/$HW
    fi

    if [[ -d /usr/cbs/hacks/bin ]]; then
        export PATH=$PATH:/usr/cbs/hacks/bin
    fi

    # python
    if [[ -d /usr/local/python/bin ]]; then
        export PATH=/usr/local/python/bin:$PATH
    fi

    # /usr/local/bin
    if [[ -d /usr/local/bin ]]; then
        export PATH=$PATH:/usr/local/bin
    fi

    # ~/bin
    if [[ -d $HOME/bin ]]; then
        export PATH=$HOME/bin:$PATH
    fi

fi

export MAIL="$HOME/mail/mbox"
export MAILCHECK=0
export EDITOR=vi
export SVN_EDITOR=vi
export VISUAL=vi


bindkey -v # vi mode enable
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^t" push-line-or-edit
bindkey "^_" insert-last-word
bindkey -a u undo
bindkey -a '^R' redo


autoload -U zutil
#autoload -U complist # don't like this
autoload -Uz compinit && compinit -i
autoload -U zmv


# options 

setopt nobeep
setopt EXTENDED_GLOB
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
unsetopt AUTO_MENU
unsetopt MENU_COMPLETE
setopt INTERACTIVE_COMMENTS # this would not be executed
setopt AUTOPUSHD
setopt PUSHDIGNOREDUPS
setopt MULT_IOS


# aliases

if [[ $HOST == $LOCAL ]]; then 
    alias vi="Open -a MacVim"
    alias top=htop
    alias fuck='$(thefuck $(fc -ln -1))' #autocorrect commands https://github.com/nvbn/thefuck
    alias shuf='gshuf'
    alias sort='gsort'
fi

#alias -g sam='nl | shuf | head | sort -n | cut -f2-'
alias todo="vi ~/todo"
alias sz="ssh-agent zsh"
alias sa="ssh-add"
alias so="screen -e^Oa -h 5000"
alias pm="sudo perl -MCPAN -eshell"
alias -g hist="sort | uniq -c | sort -n" # global alias for this
#alias top="top -o cpu -O +rsize -s 5 -n 20"
alias mmv='noglob zmv -W'
alias history-stats="history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head"

# set up aliases for recently used directories
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# better downloading
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi


# servers etc
alias dtu="tail -n 2 ~/data/dtu"
alias cbs="ssh -Y helen@interaction.cbs.dtu.dk"
alias ome="ssh -Y hecook@computerome.cbs.dtu.dk"
alias padawan="ssh -Y helen@padawan.cbs.dtu.dk"
alias gatlas="ssh -L8080:gatlas.cbs.dtu.dk:8080 helen@interaction.cbs.dtu.dk"


# Fix files added by Google Drive
alias noicon="find . -name Icon$'\r' -print0|xargs -0 rm"
alias icon="find . -name Icon$'\r'"


# Other config files

#source ~/data/app/PyRosetta.MacOSX.Lion-r54935.64Bit/SetPyRosettaEnvironment.sh
if [[ -e ~/.zshrc-tokens ]]; then source ~/.zshrc-tokens; fi # set up api tokens etc

