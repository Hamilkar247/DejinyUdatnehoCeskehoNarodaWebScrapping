#!/bin/bash

curl https://www.youtube.com/channel/UCrxiB9hbRtIZtEHPeW2mnqA/videos | html2text -utf8 | awk '/Przesłane filmy/,/Język:  Polski/' | awk '/Dějiny_udatného_českého_národa_/'
