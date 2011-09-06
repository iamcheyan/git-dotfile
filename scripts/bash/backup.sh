#!/bin/bash
# system backup

HOME=/home/vayn
DEST=/opt/backup

if [[ $UID != 0 ]]; then
  echo "[1;31mMust be executed as root user.[0m"
  exit 1
fi

truecrypt $HOME/Dropbox/Private/sysbak $DEST

if [[ $? -ne 0 ]]; then
  echo "[1;31mFail to mount truecrypt volume.[0m"
  exit 65
fi

date=`date "+%F"`
backupname="$date.tar"
filecount=$(ls -1 "$DEST" | wc -l)
oldestfile=$(ls -1 -t "$DEST" | tail -1)

declare -A includes
includes=(
  [ssh]=$HOME/.ssh
  [config]=$HOME/.config
  [mutt]=$HOME/.mutt
  [etc]=/etc
  [grub]=/boot/grub/menu.lst
  [pacman]=/var/lib/pacman/local
  [cron]=/var/spool/cron
  [bin]=/usr/local/bin
)

echo -n "Are you ready to backup? (y/n): "
read executeback

if [[ $executeback = 'y' ]]; then
  echo "[32mBackup started[0m"

  if [[ $filecount -gt 2 ]]; then
    rm "$DEST/$oldestfile"
  fi

  mkdir /tmp/backup

  for i in "${!includes[@]}"; do
    tar -czpf "/tmp/backup/$i.tar.gz" "${includes[$i]}" 2>/dev/null
  done

  tar -cvf "$DEST/$backupname" -C /tmp backup/
  rm -r /tmp/backup

  du -hs "$DEST"
  truecrypt -d

  echo "[32mBackup finished[0m"
fi
