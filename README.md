# Co to jest?

Za pomocą skryptu `.cmd` możemy nagrywać w Windows dźwięk z urządzeń audio podłączonych do komputera.

Dzięki harmonogramowi zadań (Tasks Scheduler) możemy ustawić nagrywanie co godzinę, po każdym uruchomieniu komputera itp. Ale większe możliwości mają dodatkowe programy, takie jak [Z-Cron](https://www.z-cron.com/).

Zadaniem poniższego rozwiązania jest nagrywanie dźwięku z dowolnego źródła audio podłączonego do komputera i zapisywanie plików z nagraniami w stałym intervale czasowym, np. co godzinę, przy czym nagrywanie zawsze będzie rozpoczynać się o pełnej godzinie (działa jak zadania CRON na serwerze UNIX).

# Instrukcja instalacji i użytkowania

1. Zainstaluj `Composer` - wersja _Mini_ wystarczy (https://getcomposer.org/)
1. Zainstaluj `cmder` (http://cmder.net/)
1. Uruchom `Cmder` (Start -> Uruchom -> `cmder` -> `OK`)
1. Przejdź do `C:\`  wpisując `c:`
1. Utwórz katalog `qLog` wpisując `mkdir "qLog"`
1. Przejdź do katalogu `qLog` wpisując `cd qLog`
1. Zainstaluj `qLog` poprzez composer: `composer require qrzysio/qlog`

# Konfiguracja nagrywania

Teraz należy wybrać urządzenie, z którego będziemy nagrywać i wpisać je w skrypcie. Aby to zrobić należy wykonać poniższe kroki.

1. W cmder wpisujemy `ffmpeg -hide_banner -list_devices true -f dshow -i dummy`
1. Komenda wylistuje nam wszystkie urządzenia audio, z których możemy nagrywać.  Spoglądamy na sekcję `DirectShow audio devices`. Poniżej tego napisu będą urządzenia audio. Przykładowe mogą wyglądać tak:
    - "Transmit (Plantronics Savi 7xx-M)"
    - "Microphone (VIA HD Audio(Win 10))"
    - "Line-in..."
1. Kopiujemy lub przepisujemy w całości całą nazwę urządzenia, z któego chcemy nagrywać, np. `Transmit (Plantronics Savi 7xx-M)`.
1. Edytujemy w Notatniku plik `run.cmd` klikając na niego prawym klawiszem myszy i wybierając `Edytuj`.
1. W linii nr `4` widzimy takie kod: `set nazwa_urzadzenia="TU_WPISZ_NAZWE_URZADZENIA"`
1. String `TU_WPISZ_NAZWE_URZADZENIA` zamieniamy na nazwę swojego urządzenia pamiętając o pozostawieniu cudzysłowów.
1. Przykładowy wynik powinien wysglądać tak: `set nazwa_urzadzenia="Transmit (Plantronics Savi 7xx-M)"`
1. W linii `19` ustawiamy długość nagrywania. Może to być dowolna wartość, np. jedna godzin (01:00:00) lub zaledwie kilka sekund (00:00:03).

# Testy

1. Po wykonaniu powyższych czynności wracamy do kondoli `cmder` i wpisujemy: `run.cmd`
1. Na ekranie zobaczymy informację o nowej stronie kodowej, ścieżce zapisu, ustawionej długości nagrania oraz trwającym nagrywaniu i jego zakończeniu.
1. W czasie testów dobrze ustawić jest krótką wartość nagrywania, np. 3 sekundy, by móc szybko sprawdzić poprawność działania.
1. Gdy na ekranie konsoli wyświetli się napis `# Zakończono` możemy sprawdzić w folderze `recordings` czy znajduje się tam plik `.mp3` o nazwie podanej w konsoli poczas nagrywania.

# Co w środku

Nagrywanie odbywa się dzięki prostemu skryptowi shell oraz wykorzystuje darmowe narzędzie [FFmpeg](http://ffmpeg.org).

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


# FTP

Rozszerzenie FTPCopy or Z-Cron (https://www.z-cron.com/ftpcopy.html)

# Możliwe problemy

Kłopot może sprawić program antywirusowy. Konieczne może być ustawienie uruchamiania zarówno pliku `.cmd` jak i `.vbs` z uprawienieniami adminsitratora oraz wykluczonych w programie antywirusowym i/lub określonych jako zaufane.

# Źródła i pomoc




# Licencja

Skrypt bash na licencji MIT. Wykorzystywane narzędzia (np. FFmpeg, Z-Cron) są udostępniane na licencjach ustalonych przez ich autorów. Sprawdź je, zanim użyjesz.
