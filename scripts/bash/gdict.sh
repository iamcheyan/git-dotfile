#!/bin/bash
# Command line Google's dictionary

q=$(echo $* | sed 's#[ ,]#\+#g')

echo "----------------------------"

# 解释
curl --output /tmp/gdict.tmp -sA 'Mozilla/4.0' 'http://www.google.com.hk/dictionary?aq=f&langpair=en|zh-CN&q='$q'&hl=en'
cat /tmp/gdict.tmp | html2text -utf8 -nobs -style compact -width 1000 | sed -n -e '/^ /p'| sed '1,4d' | head -n -1

# 发音
curl -sA 'Mozilla' "http://translate.google.com/translate_tts?tl=en&q=$q" | play -t mp3 - > /dev/null 2>&1;

#EOF
