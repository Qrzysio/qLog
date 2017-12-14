@echo off & cls

: konfiguracja urzadzenia nagrywajacego
set urzadzenie="Transmit (Plantronics Savi 7xx-M)"

: ustawianie strony kodowej jako UTF-8
chcp 65001

: tworzymy folder jesli nie istnieje
if not exist recordings ( mkdir "recordings" )

: ustawiamy format daty za pomoca komendy powershell, bo latwiej
: w przypadku zwyklych komend godzina jest bez zera wiodacego
for /f %%a in ('powershell -Command "Get-Date -format yyyy-MM-dd-\g\o\d\z.HH.mm.ss"') do set plik=%%a
set sciezka=recordings\%plik%.mp3

: ustawiamy dlugosc nagrania GG:MM:SS
: set dlugosc=01:00:00
set dlugosc=00:00:03

: wypisujemy krotkie info
echo # Zapisywanie do:  %sciezka%
echo # Długość nagrania: %dlugosc%
echo # Trwa nagrywanie...

: wlaczamy nagrywanie
: ffmpeg -hide_banner -f dshow -i audio="Transmit (Plantronics Savi 7xx-M)" -y -t %dlugosc% "%outputpath%"
ffmpeg -hide_banner -loglevel warning -ac 2 -f dshow -i audio=%urzadzenie% -y -t %dlugosc% "%sciezka%"
echo # Zakończono

