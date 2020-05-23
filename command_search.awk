{ 
    #sprawdzo czy w linku zawiera się nastepujący string
    #!~ a to z kolei odrzuca wszystkie stringi w których znajdzie ten wyraz
    
    #if($1 ~ /www\.ceskatelevize.cz\/ivysilani/ && $1 ~ /-dejiny-udatneho-ceskeho-naroda/  && $1 !~ /bonus/)  blad byl w ceskeho-naroda zamiast ceskehonaroda
    if($1 ~ /www\.ceskatelevize.cz\/ivysilani/ && $1 ~ /-dejiny-udatneho-ceskeho/  && $1 !~ /bonus/)
    {
      if ( $1 ~ /titulky/)
        {
          print $1;
          exit;
        }
      else
        {
          if ( $1 ~ /\/$/ )
            {
              print $1"titulky";
              exit
            }
          else
            {
              print $1"\/titulky";
              #print $1"/titulky"; w poprzednim byl blad dwoch sleshy
              exit;
            }
        }
    }
 
}
