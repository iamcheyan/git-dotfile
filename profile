# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export EDITOR="vim";
export TERM="xterm-256color";
export LANG="zh_CN.UTF-8";
export LC_LANG="zh_CN.UTF-8";
export LC_CTYPE="zh_CN.UTF-8";
export LC_NUMERIC="zh_CN.UTF-8";
export LC_TIME="zh_CN.UTF-8";
export LC_COLLATE="zh_CN.UTF-8";
export LC_MONETARY="zh_CN.UTF-8";
export LC_MESSAGES="zh_CN.UTF-8";
export LC_PAPER="zh_CN.UTF-8";
export LC_NAME="zh_CN.UTF-8";
export LC_ADDRESS="zh_CN.UTF-8";
export LC_TELEPHONE="zh_CN.UTF-8";
export LC_MEASUREMENT="zh_CN.UTF-8";
export LC_IDENTIFICATION="zh_CN.UTF-8";
export PATH="$PATH:/opt/lampp/bin:/var/lib/gems/1.8/bin";
export LANGUAGE="zh_CN:zh:en";

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# if running bash
[[ -n "$BASH_VERSION" && -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

# if running zsh
[[ ! -z $ZSHRC_ENV && -f "$HOME/.zshrc" ]] && source "$HOME/.zshrc"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# vim: set fdm=marker:
