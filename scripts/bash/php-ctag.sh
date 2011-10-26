#!/bin/bash

if [ -z $1 ]; then
  language=php
else
  language=$1
fi

echo 'remove old tags file...'
rm -f tags TAGS
rm -f cscope.*

case $language in
'php')
find . -type d \( -name "compile" -o -name ".svn" -o -name "sql" \) -prune -o -name "*.${language}" -print >files
ctags -L files \
    --exclude="\.git" \
    --totals=yes \
    --tag-relative=yes \
    --PHP-kinds=+cfd-vj
    --regex-PHP='/abstract class ([^ ]*)/\1/c/' \
    --regex-PHP='/interface ([^ ]*)/\1/c/' \
    --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'

cscope -bkq -i files
rm files
;;
esac
echo 'generate completed...'
