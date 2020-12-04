@echo off & cls

:: konfiguracja urzadzenia nagrywajacego
:: set urzadzenie="Transmit (Plantronics Savi 7xx-M)"
set /p urzadzenie=<urzadzenie.ini

:: ustawianie strony kodowej
:: chcp 65001
:: chcp 852
chcp 1250

:: tworzymy folder jesli nie istnieje
if not exist recordings ( mkdir "recordings" )

:: ustawiamy format daty za pomoca komendy powershell, bo latwiej
:: w przypadku zwyklych komend godzina jest bez zera wiodacego
for /f %%a in ('powershell -Command "Get-Date -format yyyy-MM-dd-\g\o\d\z.HH.mm.ss"') do set plik=%%a
set sciezka=recordings\%plik%.mp3

:: ustawiamy dlugosc nagrania GG:MM:SS
set dlugosc=01:00:00
:: set dlugosc=00:00:03

:: wypisujemy krotkie info
echo # Zrodlo dzwieku: %urzadzenie%
echo # Zapisywanie do: %sciezka%
echo # Dlugosc nagrania: %dlugosc%
echo # Rozpoczynanie nagrywania...
echo # Wcisnij [q] by przerwac

:: wlaczamy nagrywanie
:: ffmpeg -hide_banner -f dshow -i audio="Transmit (Plantronics Savi 7xx-M)" -y -t %dlugosc% "%outputpath%"
ffmpeg.exe -hide_banner -loglevel warning -ac 2 -f dshow -i audio=%urzadzenie% -y -t %dlugosc% "%sciezka%"
echo # Koniec!

pause
