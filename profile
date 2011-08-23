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
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

[[ -z $ZSHRC_ENV && -f $HOME/.zshrc ]] && source $HOME/.zshrc

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# SSH-AGENT {{{1
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi # }}}

# vim: set fdm=marker:
