#!/bin/bash

match="$(cat searchxyz~)"
#1
if [[ "$1" == "1" ]]
  then
    google --rua "$match"
#2
elif [[ "$1" == "2" ]]
  then
    google --rua "$match" | sed 's/_/ /'
#3
elif [[ "$1" == "3" ]]
  then
    google --rua "$match" | sed 's/_/ /' | sed 's/bonusy/titulky/'
#4
elif [[ "$1" == "4" ]]
  then
    google --rua "$match" | sed 's/_/ /' | sed 's/bonusy/titulky/' | sed 's/dalsi-casti/titulky/'
#5
elif [[ "$1" == "5" ]]
  then
    google --rua "$match" | sed 's/_/ /' | sed 's/bonusy/titulky/' | sed 's/dalsi-casti/titulky/'
    echo "a teraz awk"
    awk -f command_search.awk result_search.txt~
else
  "nie podałeś numeru parametru"
fi
