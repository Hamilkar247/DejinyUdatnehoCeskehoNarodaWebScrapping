{
    
    #sprawdzo czy w linku zawiera się nastepujący string
    #!~ a to z kolei odrzuca wszystkie stringi w których znajdzie ten wyraz
    if($1 ~ /www\.ceskatelevize.cz\/ivysilani/ && $1 ~ /-dejiny-udatneho-ceskeho-naroda/  && $1 !~ /bonus/)
    {
      if ( $1 ~ /titulky/)
        {
          print $1;
          exit;
        }
      else
        { 
          print $1"/titulky";
          exit;
        }
    }
 
}
