#!/bin/bash
mkdir ~/.git-dotfile
cd ~/.git-dotfile
git init
mv ~/.vim  vim
mv ~/.vimrc vimrc
mv ~/.vimperator vimperator
mv ~/.vimperatorrc vimperatorrc
mv ~/.vromerc vromerc
mv ~/.bashrc bashrc
mv ~/.bash_aliases bash_aliases

git add vim  vimrc
echo "init:" >> Makefile
echo "\t\tln -fs \`pwd\`/vim ~/.vim" >> Makefile
echo "\t\tln -fs \`pwd\`/vimrc ~/.vimrc" >> Makefile
echo "\t\tln -fs \`pwd\`/vimperator ~/.vimperator/" >> Makefile
echo "\t\tln -fs \`pwd\`/vimperatorrc ~/.vimperatorrc" >> Makefile
echo "\t\tln -fs \`pwd\`/vromerc ~/.vromerc" >> Makefile
echo "\t\tln -fs \`pwd\`/bashrc ~/.bashrc" >> Makefile
echo "\t\tln -fs \`pwd\`/inputrc ~/.inputrc" >> Makefile
echo "\t\tln -fs \`pwd\`/bash_aliases ~/.bash_aliases" >> Makefile
echo "\t\tln -fs \`pwd\`/touchpad.sh ~/.touchpad.sh" >> Makefile

# initialize your dotfile env
make init

# do github-import ? :p
