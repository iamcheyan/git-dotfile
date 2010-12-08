# openvpn
alias ovpnt='sudo /etc/init.d/openvpn start'
alias ovpnp='sudo /etc/init.d/openvpn stop'

# xampp
alias lampp='sudo /opt/lampp/lampp'
# xampp directory permission
alias webch='sudo chmod -R 777 /opt/lampp/htdocs/'

# dictionary
alias gd='. gdict.sh'
alias dct='dictcn.py'

# binary clock
alias bclc='echo "10 i 2 o $(date +"%H%M"|cut -b 1,2,3,4 --output-delimiter=" ") f"|dc|tac|xargs printf "%04d\n"|tr "01" ".*"'

# tweet timeline
alias twi='bti -A friends'

# random command from commandlinefu
#alias cmfu='lynx --dump http://www.commandlinefu.com/commands/random/plaintext | grep .'
alias cmfu='wget -qO - http://www.commandlinefu.com/commands/random/plaintext | sed -n "1d; /./p"'

# quit terminal
alias ':q'='exit'
