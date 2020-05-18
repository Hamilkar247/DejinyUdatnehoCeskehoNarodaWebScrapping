#!/bin/bash

function extraction_subtitles
{
   echo "function extraction_subtitles"
   website=$(cat sprawdzone.txt~)
   echo "qwert $website"
   curl $website | html2text | awk '/Dějiny udatného českého národa - /,/Související/' | head "-n-1" | tail "-n+2" > udatneho_ceskeho_naroda.txt
   cat udatneho_ceskeho_naroda.txt
   echo 'wyekstrakowania napisów z strony'
   
   cat udatneho_ceskeho_naroda.txt | awk '{ gsub("*","",$1); print $0}' | sed 's/ */ /' | sed 's/ */ /'  | tr '\n' ' ' | sed 's/00:0/_00:0/g' | sed 's/_/\n/g' > ho_ceskeho_naroda.sbv
   #rm udatnetho_ceskeho_naroda.txt
   python skeho_naroda.py
   #cat ho_ceskeho_naroda.sbv
   echo 'zakończono przetwarzanie napisów'
}

function trim 
{
    #parametr -i zmienia wejsciowe na dane na efekt regexa
    echo "function trim"
    sed -i 's/^[\t ]*//;s/[\t ]*$//' "$1"
}

function search_text
{
    echo "function search_text"
    #gdy przekazywany do funkcji jest string z znakami białymi
    #to $1 zwraca pierwszy wyraz tego stringa , $2 drugi itd
    #$0 zwraca nazwe pliku w ktorym sie wykonuje
    #$@ -dolar małpa - zwraca argumenty jako tablice
    #$* zwraca zkonkatenowne wszystkie argumenty
    search='side:"ceskatelevize.cz/ivysilani/"'" dejiny udatneho ceskeho naroda ""$*"
    echo $search > searchxyz~ 
    #@up sed ma na celu podmian podkreslen na spacje - bez tego wyszukiwanie bylo falszywe
    echo $search
    google --rua "$search" | sed 's/_/ /' | sed 's/dalsi-casti/titulky/' > result_search.txt~
    awk -f command_search.awk result_search.txt~ > sprawdzone.txt~    
  }

function download_episode
{  
   if [ -z "$1" ]
   then
     echo "Nie podano https strony";
     return; 
   elif [ -z "$2" ]
   then
     echo "Nie podano numeru elementu";
     return;
   fi
   youtube-dl "$1"
   # *.mp4 - rzuca warningiem SC2035, poniższy zapis jest bezpieczniejszy
   rename "s/[0-9]+.mp4/ Odcinek $2 Napisy polsko-czeskie.mp4/" *.mp4
}

function upload_episode_yt
{
   if [ -z "$1" ]
     then
       echo "nie ma żadnego url! upload sie nie wykona!"
       exit;
   fi
   src_venv #uruchamiam selenium
   python exampleGmail.py 
   nautilus . 
}

#==================START==================
echo "witam parametr 1 $1 parametr 1"

if [ -z "$1" ]
  then
    echo "nie podano numeru odcinkai!"
    exit;
fi


#curl zwraca liste odcinków
#html2text -utf8 - dodane bo inaczej czeskie zznaczki wywala
#awk 1 - lapie text miedzy dwoma liniami
#awk 2 - zwraca linie tam gdzie jest cyfra
#trim - zdefiniowana metoda sed 's/^[\t ]*//lshttps://web.archive.org/web/20140412090608/http://www.hermit.org/Linux/ComposeKeys.html/[\t ]*$//' $1
curl https://cs.wikipedia.org/wiki/Seznam_d%C3%ADl%C5%AF_po%C5%99adu_D%C4%9Bjiny_udatn%C3%A9ho_%C4%8Desk%C3%A9ho_n%C3%A1roda | html2text -utf8 | awk '/1. Lovci_mamutů/,/111. Přípitek na závěr/' | awk '/[0-9]/' | sed 's/_/ /'  > lista_odcinkow.txt
trim lista_odcinkow.txt
cat lista_odcinkow.txt

filename='lista_odcinkow.txt'
n=1
while read line; do
var="$line"
array_episode+=("$var")    #ciapki są potrzebne bo inaczej mamy 3 razy wiecej elementow w tablicy
n=$((n+1))
done < $filename

echo "rozmiar tablicy ${#array_episode[@]} "
#echo "${array_episode[@]}"
episod=$1 #episod=34 gdy petla bedzie działać to za parametr bedzie 
var_i=$episod-1
search_text "${array_episode[$var_i]}"

#for i in "${arrayName[@]}" wnetrze tego ostatecznie do wykonania w petli
#do

extraction_subtitles 
movie_url=$(cat sprawdzone.txt~)  #NIGDY NIE PISZ movie_url = $(cat search_result.txt)
echo "koncowka \"$movie_url\" końcówka"
download_episode "$movie_url" "$episod"
upload_episode_yt "$movie_url"

