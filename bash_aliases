# fbterm + fbterm_ucimf
alias myfb='LC_CTYPE=zh_CN.UTF-8 fbterm -i fbterm_ucimf'

# openvpn
alias ovpnt='sudo /etc/rc.d/openvpn restart'
alias ovpnp='sudo /etc/rc.d/openvpn stop'

alias lily='ssh -qTfnN -D 1080 lily -p 2'
alias uc='ssh -qTfnN -D 1080 uc'

# dictionary
alias gd='. gdict.sh'
alias dct='dictcn.py'

# binary clock
alias bclc='echo "10 i 2 o $(date +"%H%M"|cut -b 1,2,3,4 --output-delimiter=" ") f"|dc|tac|xargs printf "%04d\n"|tr "01" ".*"'

# copy line in cli
alias copy='xsel -b -i'

# random command from commandlinefu
#alias cmfu='lynx --dump http://www.commandlinefu.com/commands/random/plaintext | grep .'
alias cmfu='wget -qO - http://www.commandlinefu.com/commands/random/plaintext | sed -n "1d; /./p"'

# GTD
alias t='python $HOME/local/t/t.py --task-dir $HOME/Dropbox/tasks --list tasks'
alias r='python $HOME/local/t/t.py --task-dir $HOME/Dropbox/tasks --list reading'
alias w='python $HOME/local/t/t.py --task-dir $HOME/Dropbox/tasks --list writing'

# quit terminal
alias ':q'='exit'

# read bootlog
alias blog='sed "#^`LANG=C date \"+%a %b %e\"`#\!d;s/^.\{26\}//;s/\^\[/\x1b/g" /var/log/boot.log|while read i; do echo "$i" && sleep 0.1; done'
