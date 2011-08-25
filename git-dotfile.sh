#!/bin/bash
mkdir ~/.git-dotfile
cd ~/.git-dotfile
#git init
#mv ~/.vim  vim
#mv ~/.vimrc vimrc
#mv ~/.vimperator vimperator
#mv ~/.vimperatorrc vimperatorrc
#mv ~/.vromerc vromerc
#mv ~/.bashrc bashrc
#mv ~/.bash_aliases bash_aliases

#git add vim  vimrc
echo "init:" >> Makefile
echo "\t\tln -fs \`pwd\`/vim ~/.vim" >> Makefile
echo "\t\tln -fs \`pwd\`/vimrc ~/.vimrc" >> Makefile
echo "\t\tln -fs \`pwd\`/vimperator ~/.vimperator/" >> Makefile
echo "\t\tln -fs \`pwd\`/vimperatorrc ~/.vimperatorrc" >> Makefile
echo "\t\tln -fs \`pwd\`/profile ~/.profile" >> Makefile
echo "\t\tln -fs ~/.profile ~/.zprofile" >> Makefile
echo "\t\tln -fs \`pwd\`/bashrc ~/.bashrc" >> Makefile
echo "\t\tln -fs \`pwd\`/inputrc ~/.inputrc" >> Makefile
echo "\t\tln -fs \`pwd\`/bash_aliases ~/.bash_aliases" >> Makefile
echo "\t\tln -fs \`pwd\`/xinitrc ~/.xinitrc" >> Makefile
echo "\t\tln -fs \`pwd\`/Xmodmap ~/.Xmodmap" >> Makefile
echo "\t\tln -fs \`pwd\`/Xresources ~/.Xresources" >> Makefile
echo "\t\tln -fs \`pwd\`/Xdefaults ~/.Xdefaults" >> Makefile

# initialize your dotfile env
make init

# do github-import ? :p
