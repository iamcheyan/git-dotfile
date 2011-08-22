# 原有设置 {{{1
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000
unsetopt beep
export EDITOR="vim"
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vayn/.zshrc'

fpath+=$HOME/.zsh/Completion
autoload -Uz compinit
compinit
# End of lines added by compinstall

# 确定环境 {{{1
OS=${$(uname)%_*}
[[ $OS == "CYGWIN" ]] && OS=Linux
unsetopt nomatch
# zstyle {{{1
# 自动补全 {{{2
# 用本用户的所有进程补全
[[ -x =trimdir ]] && zstyle ':completion:*:processes' command 'ps -afu$USER|trimdir' || zstyle ':completion:*:processes' command 'ps -afu$USER'
zstyle ':completion:*:*:*:*:processes' force-list always
# 进程名补全
zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

# 警告显示为红色
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
# 描述显示为淡色
zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;33m -- %d (errors: %e) --\e[0m'

# cd 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
# 在 .. 后不要回到当前目录
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:man:*' separate-sections true

zstyle ':completion:*' menu select
# 分组显示
zstyle ':completion:*' group-name ''
# 模糊匹配
# 在最后尝试使用文件名
zstyle ':completion:*' completer _complete _match _approximate _ignored _files
# 修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# 使用缓存。某些命令的补全很耗时的（如 aptitude）
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*' special-dirs \
  '[[ $PREFIX == (../)#(|.|..) ]] && reply=(..)'

compdef pkill=killall
compdef pgrep=killall
compdef vman=man
compdef proxychains=command
compdef watch=command

# 我的自动补全 {{{2
# 补全 pdf2png
zstyle ':completion:*:*:pdf2png:*' file-patterns \
  '*.pdf:pdf\ files *(-/):directories'
zstyle ':completion:*:*:x:*' file-patterns \
'*.{7z,bz2,gz,rar,tar,tbz,tgz,zip,chm,xz}:compressed\ files *(-/):directories'
zstyle ':completion:*:*:evince:*' file-patterns \
'*.{pdf,ps,eps,dvi,pdf.gz,ps.gz,dvi.gz}:Documents *(-/):directories'
zstyle ':completion:*:*:gbkunzip:*' file-patterns '*.zip'
zstyle ':completion:*:*:luit:*' file-patterns '*(*)'

# ^X-Tab 在任何地方都补全文件名
# http://stackoverflow.com/questions/2658534/bind-key-to-complete-filename-wherever-the-context-is-in-zsh
zle -C complete complete-word complete-files
bindkey "^X\t" complete
complete-files () { _files $@ }

# 设置{{{1
# 选项设置{{{2
# 立即打印 job 状态
setopt notify
# 不需要打 cd，直接进入目录
setopt autocd
# 自动记住已访问目录栈
setopt auto_pushd
setopt pushd_ignore_dups
# rm * 时不要提示
setopt rmstarsilent
# 允许在交互模式中使用注释
setopt interactive_comments
# disown 后自动继续进程
setopt auto_continue
setopt extended_glob
# 单引号中的 '' 表示一个 ' （如同 Vimscript 中者）
setopt rc_quotes
# 补全列表不同列可以使用不同的列宽
setopt listpacked
# 为方便复制，右边的提示符只在最新的提示符上显示
setopt transient_rprompt
# setopt 的输出显示选项的开关状态
setopt ksh_option_print
# 与 stty -ixon 效果一样
setopt noflowcontrol
# 历史记录{{{3
# 如果连续输入的命令相同，历史记录中只保留一个
# setopt HISTIGNOREDUPS
# 不保留重复的历史记录项
setopt hist_ignore_all_dups
# 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space

# 命令行编辑{{{2
bindkey -e
bindkey "^U" backward-kill-line
bindkey "^]" vi-find-next-char
bindkey "^[]" vi-find-prev-char
# ^J 保持当前命令行但不执行
bindkey -s "^J" "^[[A^[[B"
bindkey -s "^[[Z" "^P"
bindkey '^Xa' _expand_alias
# ^Xe 用$EDITOR编辑命令
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '^[/' _history-complete-older
# 用单引号引起最后一个单词
# FIXME 如何引起光标处的单词？
bindkey -s "^['" "^[] ^f^@^e^[\""
# 打开 zsh 的PDF格式文档
bindkey -s "^X^D" "evince ~/文档/编程/shell/zsh/zsh.pdf &^M"
bindkey -s "^Xc" "tmux attach -d^M"
bindkey -s "^Xp" "http_proxy=http://localhost:"
# History search, past commands beginning with the current be shown.
#bindkey "^[[A" history-search-backward
#bindkey "^[[B" history-search-forward
# cursor up/down look for a command that started like the one starting
# on the command line
# http://www.xsteve.at/prg/zsh/.zshrc {{{3
function history-search-end {
  integer ocursor=$CURSOR

  if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
    # Last widget called set $hbs_pos.
    CURSOR=$hbs_pos
  else
    hbs_pos=$CURSOR
  fi

  if zle .${WIDGET%-end}; then
    # success, go to end of line
    zle .end-of-line
  else
    # failure, restore position
    CURSOR=$ocursor
    return 1
  fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end #cursor up
bindkey "\e[B" history-beginning-search-forward-end  #cursor down
# 词界像 bash 那样{{{3
# autoload -U select-word-style
# select-word-style bash
# Esc-Esc 在当前/上一条命令前插入 sudo {{{3
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line
# 别名 {{{1
# 命令别名 {{{2
source "$HOME/.bash_aliases"
alias ll='ls -lh'
alias la='ls -A'
alias rsync="rsync '--exclude=*~' '--exclude=*.swp'"
if [[ $OS == 'Linux' ]]; then
  alias ls='ls --color=auto'
  [[ -x =dircolors ]] && eval "`dircolors -b`"
elif [[ $OS == 'FreeBSD' ]]; then
  alias ls='ls -G'
elif [[ $OS == 'OpenBSD' ]]; then
  alias ls='ls -F'
fi
if [[ $OS == 'Linux' || $OS == 'FreeBSD' ]]; then
  alias grep='grep --color=auto'
fi
alias l='locate'
alias lre='locate -b --regex'
alias n='nautilus --no-desktop'
alias py='python3'
alias xp="xmocp -p"
alias xg="mocp -G"
alias xq="xmocp -q"
alias xu="xmocp -u"
alias xd="xmocp -d"
alias xn="xmocp -n"
alias svim="vim -i NONE"
alias rv='EDITOR="vim --servername GVIM --remote-tab-wait"'
alias :q="exit"
alias calc="speedcrunch"
alias qcalc="qalculate"
alias html2text="html2text -nobs -style pretty"
alias less="less -R"
alias 7z="7z '-xr!*~' '-xr!*.swp'"
alias zhcon="zhcon --utf8"
alias matlab="~/soft/Matlab/bin/matlab"
alias mytex=". ~/soft/context/tex/setuptex"
alias myadb="path+=(~/soft/android-sdk-linux_x86/tools ~/soft/android-sdk-linux_x86/platform-tools)"
alias gbk="luit -encoding gb18030"
alias mpc="mpc -h ~/.mpd/socket"
alias ncmpcpp="ncmpcpp -h ~/.mpd/socket"
alias xx="file-roller -h"
alias irssi="irssi -c irc.freenode.net"
alias bat="acpitool -b"

alias winxp="VBoxManage startvm WinXP"
alias winxp2="VBoxManage startvm WinXP_test"
alias zshrc="vim ~/.zshrc"
alias ren="vim +'Ren'"
# 查看进程数最多的程序
alias topnum="ps -e|sort -k4|awk '{print \$4}'|uniq -c|sort -n|tail"
alias soul="mplayer -really-quiet -nolirc -loop 0 ~/音乐/_纯音乐/忧伤还是快乐.mp3"
alias rebootrt="wget --user=vayn --password=admin888 'http://192.168.1.1/userRpm/SysRebootRpm.htm?Reboot=%D6%D8%C6%F4%C2%B7%D3%C9%C6%F7' -O /dev/null"
alias xcp="rsync -aviHK --delete --exclude='*~'"

# 后缀别名 {{{2
alias -s xsl="vim"
alias -s {html,htm}="firefox"
alias -s {pdf,ps}="evince"
alias -s ttf="gnome-font-viewer"
alias -s {png,jpg,gif}="feh"
alias -s jar="java -jar"
alias -s swf="flashplayer"

# 路径别名 {{{2
hash -d tmp="$HOME/tmpfs"
hash -d SJ='/media/SJ'
hash -d phone='/media/PHONE\x20CARD'
hash -d gtk="$HOME/scripts/c/gtk"
hash -d js="$HOME/scripts/js"
hash -d py="$HOME/scripts/python"
hash -d lua="$HOME/scripts/lua"
hash -d java="$HOME/scripts/java"
hash -d ebook="$HOME/temp/ebook"
hash -d lily='/media/lilydjwg'
hash -d jar="/media/soft/software/jar"
hash -d xul="/media/soft/software/xul"
hash -d ff="$HOME/.mozilla/firefox/profile"
hash -d nginx="$HOME/.nginx/www"
hash -d dos="$HOME/.dosbox/programs"

# 全局别名 {{{2
alias -g LS="|less"
# 当前目录下最后修改的文件
# 来自 http://roylez.heroku.com/2010/03/06/zsh-recent-file-alias.html
alias -g NN="*(oc[1])"
alias -g NUL="/dev/null"

# 函数 {{{1
gcc () { command gcc -g -Wall $@ |& tee $HOME/tmpfs/error }
g++ () { command g++ -g -Wall $@ |& tee $HOME/tmpfs/error }
update () { . $HOME/.zshrc }
if [[ $TERM == screen* ]]; then
  # 注：不支持中文
  title () { echo -ne "\ek$*\e\\" }
else
  title () { echo -ne "\e]0;$*\a" }
fi
strace () { command strace $@ 3>&1 1>&2 2>&3 | vim - }
ltrace () { command ltrace $@ 3>&1 1>&2 2>&3 | vim - }
vman () { vim +"set ft=man" +"Man $@" }
song () { find ~/音乐 -iname "$1*" }
mvpc () { mv $1 "`echo $1|ascii2uni -a J`" } # 将以 %HH 表示的文件名改正常
nocolor () { sed -r "s:\x1b\[[0-9;]*[mK]::g" }
if [[ $(uname -a) == *Ubuntu* ]]; then # {{{ tree
  tree () {
    command tree -C $@|ascii2uni -a K 2>/dev/null
  }
else
  alias tree="tree -C"
fi
2mp3 () { # 转换成 mp3 格式 {{{2
  [[ $# -ne 1 ]] && echo "Usage: $0 FILE" && return 1
  mplayer -vo null -vc dummy -af resample=44100 -ao pcm:waveheader "$1" && \
  lame -m s audiodump.wav -o "$1:r.mp3" && rm audiodump.wav || \
  {echo Failed. && return 2}
}
sdu () { #排序版的 du {{{2
  du -sk $@ | sort -n | awk '
BEGIN {
  split("K,M,G,T", Units, ",");
  FS="\t";
  OFS="\t";
}
{
  u = 1;
  while ($1 >= 1024) {
    $1 = $1 / 1024;
    u += 1
  }
  $1 = sprintf("%.1f%s", $1, Units[u]);
  sub(/\.0/, "", $1);
  print $0;
}'
}
sshget () { # 通过 ssh 下载文件（国外）{{{2
  if [[ $# -ne 2 ]]; then
    echo "Usage: $0 URL FILE"
    return 1
  fi
  ssh shell.cjb.net "wget -q -O - $1"|pv > $2
}
sshget2 () { # 通过 ssh 下载文件（国内）{{{2
  if [[ $# -ne 2 ]]; then
    echo "Usage: $0 URL FILE"
    return 1
  fi
  ssh ubuntu.unix-center.net "wget -q -O - '$1'"|pv > $2
}
gbmv () { # 文件名从 GB 转码，带确认{{{2
  for i in $@; do
    new="`echo $i|iconv -f utf8 -t latin1|iconv -f gbk`"
    echo $new
    echo -n 'Sure? '
    read -q ans && mv -i $i $new
  done
}
iip () { #{{{2
  echo -n "ip> "
  read ip
  while [[ $ip != 'q' ]]; do
    cip $ip
    echo -n "ip> "
    read ip
  done
  unset ip
}
pid () { #{{{2
  s=0
  for i in $@; do
    echo -n "$i: "
    r=`cat /proc/$i/cmdline|tr '\0' ' ' 2>/dev/null`
    if [[ $? -ne 0 ]]; then
      echo not found
      s=1
    else
      echo $r
    fi
  done
  return $s
}
proxy () { #常用代理一起启动{{{2
  ~/soft/g/gappproxy-1.0.0beta/localproxy/proxy.py&
  ~/soft/g/gappproxy-2.0.0/proxy.py &
  ~/soft/g/wallproxy/local/proxy.py &
  python2.6 ~/scripts/python/pyexe/ubuntu2.pyc&
  # ~/soft/g/APJP/JAVA/APJP.sh&
}
s () { # 快速查找当前目录下的文件 {{{2
  name=$1
  shift
  find . -name "*$name*" $@
}
shutdown () { #{{{2
  echo -n 你确定要关机吗？
  read i
  if [[ $i == [Yy] ]]; then
    dbus-send --system --print-reply --dest=org.freedesktop.Hal /org/freedesktop/Hal/devices/computer org.freedesktop.Hal.Device.SystemPowerManagement.Shutdown
  fi
}
tianqi () { #天气预报 {{{2
  if [[ $# -eq 1 ]]; then
    city=$1
  elif [[ $# -eq 0 ]]; then
    city=武汉
  else
    echo "城市？" >&2
    return 1
  fi
  w3m -dump "http://3g.sina.com.cn/prog/wapsite/weather_new/forecast_new.php?city=$city&vt=4" 2>/dev/null | sed '1,/转发至微博/d;/生活指数/,$d;s/\[[^]]\+\]//g'
}
[[ -x /usr/lib/command-not-found ]] && command_not_found_handler () { # {{{2
  /usr/lib/command-not-found -- $@ |& sed 's/apt-get/aptitude/g' >&2
  return -1
}
# 变量设置 {{{1
# zsh{{{2
# 提示符
# %n --- 用户名
# %~ --- 当前目录
# %h --- 历史记录号
PS1="%{[2m%}%h %(?..%{[1;31m%}%? )%{[32m%}%~
%(!.%{[0;31m%}###.%{[1;34m%}>>>)%{[0m%} "
# 次提示符：使用暗色
PS2="%{[2m%}%_>%{[0m%} "
# 右边的提示
RPS1="%(1j.%{[1;33m%}%j .)%{[m%}%T"
CORRECT_IGNORE='_*'
READNULLCMD=less

# TeX{{{2
export TEXMFCACHE=$HOME/.cache
export OSFONTDIR=$HOME/.fonts

# gstreamer mp3 标签中文设置{{{2
export GST_ID3_TAG_ENCODING=GB18030:UTF-8
export GST_ID3V2_TAG_ENCODING=GB18030:UTF-8

# 图形终端下(包括ssh登录时)的设置{{{2
if [[ -n $DISPLAY || -n $SSH_TTY ]]; then
  # 让 less 将粗体/下划线等显示为彩色
  export LESS_TERMCAP_mb=$'\x1b[01;31m'
  export LESS_TERMCAP_md=$'\x1b[01;38;5;74m'
  export LESS_TERMCAP_me=$'\x1b[0m'
  export LESS_TERMCAP_se=$'\x1b[0m'
  export LESS_TERMCAP_so=$'\x1b[7m'
  export LESS_TERMCAP_ue=$'\x1b[0m'
  export LESS_TERMCAP_us=$'\x1b[04;38;5;146m'

  [[ $TERM == *color* ]] || export TERM=${TERM%%[.-]*}-256color
  # 支持256色
  [[ $OS = FreeBSD ]] && export TERMCAP='xterm|xterm-256color:Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm:tc=xterm-xfree86:'
fi
# 通用{{{2
# 在图形界面下使用火狐作为默认浏览器
[[ -n $DISPLAY ]] && export BROWSER=firefox
[[ -n $SSH_TTY ]] && unset BROWSER
# 其它 {{{1

[[ -f /etc/profile.d/autojump.zsh ]] && . /etc/profile.d/autojump.zsh
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
[[ -f $HOME/.zsh/zshrc.local ]] && source $HOME/.zsh/zshrc.local

unset OS
setopt nomatch
return 0

# vim:fdm=marker:ft=sh
