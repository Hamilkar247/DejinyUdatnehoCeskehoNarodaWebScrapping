#!/usr/bin/env python

from googletrans import Translator
import os

# format min i sec
def format_min_sec(time_form:int) -> str:
    if time_form < 10:
        return "0"+str(time_form)
    else:
        return str(time_form)

# convert subtitles to youtube format
def convToYoutubeTimeFormat(time_str:str,last_element_time:str) -> str:
    time_str_out = time_str + ".000,"
    time_str_out = time_str_out + last_element_time + ".000"
    return time_str_out

# Translate CZ to PL
def translateCZtoPL(translator: Translator, only_text: str) -> str:
    transCZtoPL = translator.translate(only_text, src='cs', dest='pl')
    return transCZtoPL.text

def main():
    file_name = "ho_ceskeho_naroda.sbv"
    #zwraca aktualny folder-ważne bo usunięcie pliku bez ścieszki usuwa plik z miejsca wywołania
    bas_dir = os.path.dirname(os.path.realpath(__file__))
    print('realpath:' + bas_dir)
    file = open(bas_dir+'/'+file_name,'r')
    lyrics_of_episod = file.read().split('\n')
    file.close()
    os.remove(bas_dir+'/'+file_name)
    # w trybie w, czyści zawartośc tego pliku
    file = open(bas_dir+'/'+file_name, 'w') 
    translator = Translator()
    last_element_time = lyrics_of_episod[-1][1:8]
    record = ""
    for line in reversed(lyrics_of_episod):
        if line != "" and line != " ":
            time_in_line = convToYoutubeTimeFormat(line[1:8],last_element_time)
            last_element_time = time_in_line[0:7]
            only_text = line[9:-1]   #sam tekst bez czasu
            translate_text = translateCZtoPL(translator, only_text)
            record = record+ "_" +f"{time_in_line}\n {only_text} \n {translate_text}\n\n"
    last_arrays = record.split("_")
    for line in reversed(last_arrays):
        file.write(line)
    file.close()
    print('Hej:'+last_element_time) 

if __name__ == "__main__":
    main()
