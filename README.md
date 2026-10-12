# Task Manager

Internetowy system zarządzania zadaniami tworzony w ramach praktyk INF.03.

## Opis projektu

Task Manager to aplikacja webowa, w której użytkownik może zapisywać swoje zadania, oglądać je w jednym miejscu i oznaczać, na jakim etapie się znajdują. Zamiast notatek rozrzuconych w różnych miejscach wszystkie sprawy do zrobienia są zebrane w jednej, uporządkowanej liście.

Projekt składa się z trzech części: strony internetowej (frontend), serwera z API (backend) oraz bazy danych, w której przechowywane są zadania.

## Cel projektu

Głównym celem jest nauczenie się, jak wygląda praca nad prawdziwą aplikacją od początku do końca. W trakcie realizacji projektu chcę:

- zaprojektować i wykonać prosty interfejs użytkownika,
- zbudować API, które obsługuje zadania i łączy się z bazą danych,
- poznać pracę zespołową w Git i GitHub (branche, pull requesty, code review),
- nauczyć się dokumentować projekt i pilnować jakości kodu za pomocą CI.

## Funkcjonalności

- dodawanie nowych zadań,
- edycja istniejących zadań,
- usuwanie zadań,
- zmiana statusu zadania (np. do zrobienia, w trakcie, zrobione),
- wyszukiwanie i filtrowanie zadań.

## Technologie

| Część projektu | Technologie |
|---|---|
| Frontend | HTML, CSS, JavaScript |
| Backend | API w języku wybranym w kolejnych etapach (np. C#) |
| Baza danych | PostgreSQL |
| Kontrola wersji | Git i GitHub |
| Automatyczne sprawdzanie kodu | GitHub Actions (CI) |

## Struktura projektu

```text
frontend/   strona internetowa (widoki, style, skrypty)
backend/    serwer i API
database/   skrypty i opis bazy danych
docs/       dodatkowa dokumentacja i zrzuty ekranu
tests/      testy aplikacji
```

## Uruchomienie

Ta sekcja zostanie uzupełniona w kolejnych etapach projektu.

## Status projektu

- [x] Utworzenie repozytorium
- [x] Konfiguracja zabezpieczeń gałęzi `main`
- [x] Dodanie CI w GitHub Actions
- [x] Przygotowanie dokumentacji
- [ ] Przygotowanie frontendu
- [ ] Utworzenie API
- [ ] Połączenie z bazą danych
