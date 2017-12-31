# Co to jest?

Za pomocą skryptu `.cmd` możemy nagrywać w Windows dźwięk z urządzeń audio podłączonych do komputera.

Dzięki harmonogramowi zadań (Tasks Scheduler) możemy ustawić nagrywanie co godzinę, po każdym uruchomieniu komputera itp. Ale większe możliwości mają dodatkowe programy, takie jak [Z-Cron](https://www.z-cron.com/).

Zadaniem poniższego rozwiązania jest nagrywanie dźwięku z dowolnego źródła audio podłączonego do komputera i zapisywanie plików z nagraniami w stałym intervale czasowym, np. co godzinę, przy czym nagrywanie zawsze będzie rozpoczynać się o pełnej godzinie (działa jak zadania CRON na serwerze UNIX).

### Co w środku

Nagrywanie odbywa się dzięki prostemu skryptowi shell oraz wykorzystuje darmowe narzędzie [FFmpeg](http://ffmpeg.org).

# Instrukcja instalacji i użytkowania

1. Pobierz to repozytorium jako plik `.zip`.
1. Wypakuj pliki do `C:\qLog` (lub innego folderu).
1. Zainstaluj `cmder` (http://cmder.net/)
1. Uruchom `Cmder` (Start -> Uruchom -> `cmder` -> `OK`)
1. Przejdź do `C:\`  wpisując `c:`
1. Przejdź do katalogu `qLog` wpisując `cd qLog`
1. Nie zamykaj konsoli, będzie potrzebna do testów.

# Konfiguracja nagrywania

Teraz należy wybrać urządzenie, z którego będziemy nagrywać i wpisać je w skrypcie. Aby to zrobić należy wykonać poniższe kroki.

1. W cmder wpisujemy `ffmpeg -hide_banner -list_devices true -f dshow -i dummy`
1. Komenda wylistuje nam wszystkie urządzenia audio, z których możemy nagrywać.  Spoglądamy na sekcję `DirectShow audio devices`. Poniżej tego napisu będą urządzenia audio. Przykładowe mogą wyglądać tak:
    - "Transmit (Plantronics Savi 7xx-M)"
    - "Microphone (VIA HD Audio(Win 10))"
    - "Line In (Sound Blaster Audigy Fx)"
1. Kopiujemy lub przepisujemy w całości całą nazwę urządzenia, z któego chcemy nagrywać, np. `Transmit (Plantronics Savi 7xx-M)`.
1. Edytujemy w Notatniku plik `urzadzenie.ini` klikając na niego prawym klawiszem myszy i wybierając `Edytuj`.
1. W pierwszej linii wpisujemy nazwę swojego urządzenia pamiętając o __pozostawieniu cudzysłowów__.
1. Przykładowy wpis w pliku powinien wyglądać tak: `"Transmit (Plantronics Savi 7xx-M)"`
1. W linii `19` ustawiamy długość nagrywania. Może to być dowolna wartość, np. jedna godzina (01:00:00) lub zaledwie kilka sekund (00:00:03).

# Testy

1. Po wykonaniu powyższych czynności wracamy do konsoli `cmder` i wpisujemy: `run.cmd`
1. Na ekranie zobaczymy informację o nowej stronie kodowej, ścieżce zapisu, ustawionej długości nagrania oraz trwającym nagrywaniu i jego zakończeniu.
1. W czasie testów dobrze ustawić jest krótką wartość nagrywania, np. 3 sekundy, by móc szybko sprawdzić poprawność działania.
1. Gdy na ekranie konsoli wyświetli się napis `# Zakończono` możemy sprawdzić w folderze `recordings` czy znajduje się tam plik `.mp3` o nazwie podanej w konsoli poczas nagrywania.

# Harmonogram

Harmonogram nagrywania można ustawić przy pomocy "Harmonogramu zadań" w Windows lub wykorzystać zewnętrzne narzędzie, np. [Z-Cron](https://www.z-cron.com/)

### Konfiguracja Z-Cron

1. Po uruchomieniu programu klikamy `Tasks` i na dole przycisk `Create new CronJob`.
1. Podajemy własną nazwę i opis.
1. W polu `Program` Wskazujemy ścieżkę do pliku `start.vbs` (np. `C:\qLog\start.vbs`).
1. Zaznaczamy pola `Activate task` i `Autostart`.
1. Przechodzimy do zakładki `Scheduler` i klikamy pod zegarem po lewej stronie przycisk `Scheduler`.
1. Wybieramy interesujące nas ustawienia, na dole są także dostępne zbiorcze presety, np. `Co pięć minut`.
1. Po zakończeniu konfiguracji klikamy `Save` i `Exit`, a w oknie głównym `Desktop`. Dzięki temu program nie zamknie się, lecz zostanie zminimalizowany do zasobnika.

### Wyjaśnienie skrótów FFmpeg

Polecenie:
```
ffmpeg -hide_banner -loglevel warning -ac 2 -f dshow -i audio=%urzadzenie% -y -t %dlugosc% "%sciezka%"
```

- `-hide_banner` - ukrywa informacje o wersji i kodekach
- `-loglevel warning` - wyświetla tylko ostrzeżenia i błędy (bez info itp.)
- `-ac 2` - ustawia stereo
- `-f dshow` - ustawia format
- `-i audio=%urzadzenie%` - ustawia źródło dźwięku
- `-y` - nadpisuje plik wyjściowy, gdy istnieje
- `-t %dlugosc%` - ustawia długość nagrywania
- `"%sciezka%"` - ścieżka do pliku z nagraniem

Szczegóły: http://ffmpeg.org/ffmpeg.html#Main-options

### FTP

Rozszerzenie FTPCopy dla Z-Cron (https://www.z-cron.com/ftpcopy.html)

Konfiguracja jest prosta, ale trzeba to dobrze przetestować, bo zapora w Windows może pytać o potwierdzenie wykonania zadania. W takiej sytuacji trzeba najpierw dodać wyjątek (potwierdzić jego dodanie).
Po utworzeniu zadania wysyłania na FTP należy kliknąć na zadanie w Z-Cron prawym klawiszem myszy i wybrać "Start".

Inna opcją jest edytowanie zadania i w ścieżce docelowej na serwerze kliknąć "przeglądaj", wtedy program łączy się z FTP i podczas łączenia pojawi się komunikat zapory.

### Strony kodowe w run.cmd

W różnych wersjach Windows na ekranie konsoli możemy mieć lub nie mieć poprawie wyświetlonych polskich znaków.

I tak w Windows 7 strona kodowa konsoli to `852`, a gdy jeśli ustawimy kodowanie na `UTF-8` to do pliku `.mp3` system dopisze nam dodatkowe bajty, tzw. BOM, których nie chcemy. Widać to listując pliki, naierpawidłowa nazwa z dodatkowymi bajtami wygląda np.tak: `''$'\357\273\277''2017-12-31-godz.07.00.02.mp3'`.

Aby tego uniknąć ustawiamy stronę kodową na `Windows-1250` poleceniem `chcp 1250` w pliku `run.cmd`. Ale teraz także ten plik musi być zapisany w kodowaniu `Windows-1250`, więc trzeba o to zadbać w edytorze tekstu.

Kilka słów na ten temat ze strony [Grzegorza Niemirowskiego](https://www.grzegorz.net/articles/index.php?id=conenc).
> Jak powszechnie wiadomo, windowsowy wiersz polecenia (cmd.exe) używa kodowania 852, takiego samego jak używał DOS. Cała reszta systemu Windows używa natomiast kodowania Windows-1250, znanego też jako CP1250, oraz Unicode. Podczas gdy konwersja z Windows-1250 na Unicode następuje automatycznie i w sposób praktycznie przezroczysty dla użytkownika to z 852 już jest problem. Łatwo się o tym przekonać tworząc w Notatniku plik z polskimi literami i próbując go wyświetlić poleceniem type. Będziemy mieć krzaki. Tak samo jest w drugą stronę. Okazuje się jednak, że można zmieniać stronę kodową wiersza polecenia. Służy do tego polecenie mode con cp select= lub w skrócie chcp. Aby zmienić kodowanie na Windows-1250 wpisujemy:
> `mode con cp select=1250`
> lub
> `chcp 1250`
> Wiersz polecenia obsługuje też wiele innych kodowań, np. ISO-8859-2 (standard w polskim Internecie, używany też m.in. w Linuksie) oraz UTF-8. Aby ustawić kodowanie ISO-8859-2 należy jako parametr podać liczbę 28592 a dla UTF-8 65001.

# Możliwe problemy

Jeżeli podczas testów konsola wyświetla wiele błędów o nieprawiddłowych komendach najczęściej oznacza to, że znaczniki końca linii ustawione zostały na `LF` zamiast `CRLF`. Kliknij prawym klawiszem myszy na `start.cmd` i wybierz `Edytuj`. Jeżeli wszystkie komendy znajdują się w jednej linii, należy poprawić ręcznie składnię lub spróbować ponownie pobrać repozytorium.

Kłopot może sprawić program antywirusowy. Konieczne może być ustawienie uruchamiania zarówno pliku `.cmd` jak i `.vbs` z uprawienieniami adminsitratora oraz wykluczonych w programie antywirusowym i/lub określonych jako zaufane.

# Źródła i pomoc

Inspiracją do powstania tego poradnika były wpisy na forum stackoverlow.com.

- [How to record sound 24/7](https://superuser.com/a/548127/582502)
- [Scheduling silent (...)](https://superuser.com/a/546062/582502)

# Jeszcze więcej

- Program [AutoHotkey](https://www.dobreprogramy.pl/AutoHotkey,Program,Windows,12731.html) umożliwia zapisywanie konkretnych zautomatyzowanych zadań jako pliki `.exe`

# Licencja

Skrypt bash na licencji MIT. Wykorzystywane narzędzia (np. FFmpeg, Z-Cron) są udostępniane na licencjach ustalonych przez ich autorów. Sprawdź je, zanim użyjesz.
