#!/bin/bash
# @Author: Vayn a.k.a. VT <vayn@vayn.de>
# @Name: clean.sh
# @Date: 2011年08月24日 星期三 03时30分22秒

#tar -cjf /store/bak/pacman-database.tar.bz2 /var/lib/pacman/local
pacman -Rscn $(pacman -Qtdq)
pacman -Sc
pacman-optimize && sync
updatedb

exit
